import os
import firebase_admin
from firebase_admin import storage
from firebase_admin import credentials
from uuid import uuid4 # generate access tokens



# Parses all images and maps the title to the image data.
# Returns a Map<String, String>
def generateMapWithLessonNameAndImageLocation():

    # path to image folder
    imageFolderPath = os.path.expanduser("~/Desktop/Lesson Images")
    # List of all image names
    folder = os.listdir(imageFolderPath)

    titleAndLocation = {}
    for imageName in folder:
        noExtentionName = imageName[0:imageName.index(".")]
        fullImagePath = imageFolderPath + f"/{imageName}"
        titleAndLocation[noExtentionName.lower()] = fullImagePath;

    #print(titleAndLocation)
    return titleAndLocation

# Creates the long lived download url
def createLongLivedDownloadUrl(fileName, token):

    lessonBucket = "makeshift-homeschool-281816.appspot.com/o/lessons"
    accessToken = f"?alt=media&token={token}"
    url = f"https://firebasestorage.googleapis.com/v0/b/{lessonBucket}%2F{fileName}{accessToken}"
    return url




def uploadImageAndReturnUrl(storage, postUid, imagePath):

    # Firebase Storage Bucket to place the image
    bucket = storage.bucket(name=r'makeshift-homeschool-281816.appspot.com')

    # Access Token metadata
    accessToken = uuid4()
    metadata = {"firebaseStorageDownloadTokens": accessToken}

    # location to place the image in the bucket
    blob = bucket.blob(f'lessons/{postUid}')
    blob.metadata = metadata # set access token with image
    blob.upload_from_filename(imagePath)

    url = createLongLivedDownloadUrl(postUid, accessToken)
    return url;


#test_upload()
generateMapWithLessonNameAndImageLocation()