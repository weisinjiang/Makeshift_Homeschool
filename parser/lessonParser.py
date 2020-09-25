import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore, storage
import os
import docx
import re
import imageParser



# NOTES
# Be sure to install the firebase-admin and python-docx packages into your project
# Make sure you have opencv-python-headless installed to use cv2
# Image Folder on Desktop is named "Images for lessons"
# Lesson Folder on Desktop is named "Lessons with tags"



# Gets Firebase uid for creators
def getCreatorUid(name):
    contentCreators = {
        "Joseph McPhail": "a0BTYBqCE9gnMK8j60dRicNArkI2",
        "Sumay McPhail": "wQGkBorxtMghEg37GLl1BZMf8j32",
        "Aila McPhail": "MdxiRsClquMrlMc9nZxotZNwjI72",
        "Seth Peleg": "1qJlCn0U4HVJS2urQPoAYsO3KD63",
        "William Denherder": "gS7CD2VeXfV8KcjdM1sBxz0oT992",
        "James McCoy": "04cmEhCGuGTrrOj9XirQr6bFLLG2",
        "Lihong McPhail": "F8XRw14A5kXUYCzuSrKhK3qxkUI2"
    }
    return contentCreators[name]

# Gets email for lesson creator
def getCreatorEmail(name):
    emails = {
        "Joseph McPhail": "joseph.e.mcphail@gmail.com",
        "Sumay McPhail": "sumay.l.mcphail@gmail.com",
        "Aila McPhail": "aila.mcphail@gmail.com ",
        "Seth Peleg": "sethvpeleg13@gmail.com",
        "William Denherder": "william.parker.denherder@gmail.com",
        "James McCoy": "jamesphilipmccoy@yahoo.com",
        "Lihong McPhail": "lihong.l.mcphail@gmail.com"
    }
    return emails[name]


# Gets rid of the tag <> and left with only the value inside
def getTagType(string):
    return string.replace("<", "").replace(">", "")


# Gets the string that is in-between the start and end HTML style tags
def removeTagFromString(string, startTag, endTag):
    return string.replace(startTag, "").replace(endTag, "").strip()


# Generate a question object for a single question
def generateQuestion(contents):

    # regex to match HTML tags <>
    regEx_matchHTML = re.compile(r"\<(.*?)\>")
    questionJson = {
        "question": "",
        "options": [],
        "correctOption": ""
    }
    for question in contents:
        matches = regEx_matchHTML.match(question)
        startTag = matches.group()
        endTag = startTag[0] + "/" + startTag[1:]
        tagRemovedStr = removeTagFromString(question, startTag, endTag)
        questionType = getTagType(startTag)
        if ("question" in questionType):
            questionJson["question"] = tagRemovedStr
        # Option 1 is always the correct answer
        elif (questionType == "option1"):
            questionJson["correctOption"] = tagRemovedStr
            questionJson["options"].append(tagRemovedStr)
        else:
            questionJson["options"].append(tagRemovedStr)

    return questionJson


# Retrieves data that is ONLY the post: intro, body, conclusion
def generatePostContents(contents):
    # Post contents, intro, body and conclusion
    postContents = {

    }
    # regex to match HTML tags <>
    regEx_matchHTML = re.compile(r"\<(.*?)\>")

    for content in contents:
        matches = regEx_matchHTML.match(content)
        startTag = matches.group()
        endTag = startTag[0] + "/" + startTag[1:]
        tagRemovedStr = removeTagFromString(content, startTag, endTag)
        paragraphType = getTagType(startTag)
        if paragraphType == "intro":
            postContents["introduction"] = tagRemovedStr
        elif paragraphType == "conclude":
            postContents["conclusion"] = tagRemovedStr
        else:
            paragraphType = paragraphType[:4] + " " + paragraphType[-1]
            postContents[paragraphType] = tagRemovedStr

    return postContents


def parse_lesson(storage, database):
    # Desktop/lessons folder
    lesson_folder_path = os.path.expanduser("~/Desktop/Lessons with tags")

    # all lesson doc names in the directory
    dir_files = os.listdir(lesson_folder_path)

    # Get the image names and their location on Desktop
    imageLocations = imageParser.generateMapWithLessonNameAndImageLocation()

    # For each of the file names
    for file in dir_files:
        # makes sure the file ends with .docx extention
        if (".docx" not in file):
            continue
        else:
            postContents = {}
            # get its full path in os
            filePath = lesson_folder_path + f"/{file}"
            fileName = file[:file.index(".")].lower()
            print(f"Processing: {fileName}")
            # Open the document
            document = docx.Document(filePath)
            # Content to be added
            contents = []
            # for each paragraph, add the text to contents
            for paragraph in document.paragraphs:
                if paragraph.text != "":
                    contents.append(paragraph.text)


            postTitle = removeTagFromString(contents[0], "<title>", "</title>")
            postOwner = removeTagFromString(contents[1], "<ownerName>", "</ownerName>")
            postAge = removeTagFromString(contents[2], "<age>", "</age>")
            # index 2-6 are post contents: intro, body, conclusion
            postContents = generatePostContents(contents[3:8])
            # index 7-11 are questions on intro
            introQuestion = generateQuestion(contents[8:13])
            # index 12-16
            bodyQuestion = generateQuestion(contents[13:18])
            # index 17-end
            conclusionQuestion = generateQuestion(contents[18:])

            # Firestore Document Reference and generated post id
            documentRef = database.collection(u"lessons").document();
            # upload the image and get the long lived url
            url = imageParser.uploadImageAndReturnUrl(storage, documentRef.id, imageLocations[fileName])


            # Format of the data. Url is placeholder should there be no corresponding image
            # Lesson id is blank because we need to make a document ref in Firestore first
            data = {
                "age": postAge,
                "approvals": 2,
                "createdOn": "2020-09-24 10:15:47.623439",
                "imageUrl": url,
                "lessonId": documentRef.id,
                "likes": 0,
                "ownerName": postOwner,
                "ownerEmail": getCreatorEmail(postOwner),
                "ownerUid": getCreatorUid(postOwner),
                "postContents": postContents,
                "quiz": {
                    "body": bodyQuestion,
                    "conclusion": conclusionQuestion,
                    "intro": introQuestion
                },
                "raters": 1,
                "rating": 5.0,
                "title": postTitle,
                "views": 0
            }

            documentRef.set(data)

            print("\n")
            print(f"{fileName} added...")


# Sets a connection to the Cloud project
def main():
    credential_location = os.path.dirname(os.path.realpath(__file__)) + "/credentials.json"
    lesson_folder_path = os.path.expanduser("~/Desktop/lessons")
    cred = credentials.Certificate(credential_location)

    # Initalize it and the storage bucket called lessons
    firebase_admin.initialize_app(cred)
    db = firestore.client()
    # pass in firebase storage and database
    parse_lesson(storage, db)


main()

