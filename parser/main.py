import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import os
import docx
import re


# NOTES
# Be sure to install the firebase-admin and python-docx packages into your project

def getCreatorUid(name):
    contentCreators = {
        "Joseph McPhail": "a0BTYBqCE9gnMK8j60dRicNArkI2",
        "Sumay McPhail": "MONREpX4RQQj5iwVZLyhWtugsXP2",
        "Aila McPhail": "MdxiRsClquMrlMc9nZxotZNwjI72",
        "Seth Peleg": "1qJlCn0U4HVJS2urQPoAYsO3KD63",
        "William Denherder": "gS7CD2VeXfV8KcjdM1sBxz0oT992",
    }
    return contentCreators[name]


def getTagType(string):
    return string.replace("<", "").replace(">", "")


def removeTagFromString(string, startTag, endTag):
    return string.replace(startTag, "").replace(endTag, "")


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






def generatePostContents(contents):
    # Post contents, intro, body and conclusion
    postContents = {

    }
    # regex to match HTML tags <>
    regEx_matchHTML = re.compile(r"\<(.*?)\>")

    for content in contents:
        matches = regEx_matchHTML.match(content)
        startTag = matches.group()
        print(startTag)
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


# Connects to Firestore and adds the lessons
def addToDatabase(data):
    credential_location = os.path.dirname(os.path.realpath(__file__)) + "/credentials.json"
    lesson_folder_path = os.path.expanduser("~/Desktop/lessons")
    cred = credentials.Certificate(credential_location)
    firebase_admin.initialize_app(cred)
    db = firestore.client()
    db.collection(u'Test').document().set(data)


def parse_lesson():
    # Desktop/lessons folder
    lesson_folder_path = os.path.expanduser("~/Desktop/lessons")

    # all lesson doc names in the directory
    dir_files = os.listdir(lesson_folder_path)

    # For each of the file names
    for file in dir_files:
        # makes sure the file ends with .docx extention
        if (".docx" not in file):
            continue
        else:
            postContents = {}
            # get its full path in os
            #filePath = lesson_folder_path + f"/{file}"
            filePath = "/Users/weijiang/Desktop/lessons/Copy of 3D Printing 2 for app (done).docx"
            print(filePath)
            # Open the document
            document = docx.Document(filePath)
            # Content to be added
            contents = []
            # for each paragraph, add the text to contents
            for paragraph in document.paragraphs:
                if paragraph.text != "":
                    contents.append(paragraph.text)

            print(contents)



            # index 2-6 are post contents
            postContents = generatePostContents(contents[2:7])
            introQuestion = generateQuestion(contents[7:12])
            bodyQuestion = generateQuestion(contents[12:17])
            conclusionQuestion = generateQuestion(contents[17:])

            setDataFormat = {
                "age": "8",
                "approvals": 0,
                "createdOn": "2020-09-19 13:15:47.623439",
                "imageUrl": "d",
                "lessonId": "testingID",
                "likes": 0,
                "ownerEmail": "roxas",
                "ownerUid": "testing",
                "postContents": postContents,
                "quiz": {
                    "body": bodyQuestion,
                    "conclusion": conclusionQuestion,
                    "intro": introQuestion
                }
            }

            addToDatabase(setDataFormat)

            print("\n\n\n")
            break





# Connects to Firestore and adds the lessons
def connectToApp():
    credential_location = os.path.dirname(os.path.realpath(__file__)) + "/credentials.json"
    lesson_folder_path = os.path.expanduser("~/Desktop/lessons")
    cred = credentials.Certificate(credential_location)
    firebase_admin.initialize_app(cred)
    db = firestore.client()
    db.collection(u'Test').document().set({
        u'Hello': u'There'
    })


parse_lesson()
