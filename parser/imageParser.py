import cv2
import os
import firebase_admin
from firebase_admin import storage
from firebase_admin import credentials
from uuid import uuid4 # generate access tokens

# make sure you have opencv-python-headless installed to use cv2

# Parses all images and maps the title to the image data.
# Returns a Map<String, Array> where Array = 2D array with image color data
def generateMapWithLessonNameAndImageData():

    # path to image folder
    imageFolderPath = os.path.expanduser("~/Desktop/Images for lessons")
    # List of all image names
    folder = os.listdir(imageFolderPath)

    titleAndData = {}
    for imageName in folder:
        fullImagePath = imageFolderPath + f"/{imageName}"
        print(fullImagePath)
        image = cv2.imread(fullImagePath)
        if image is not None:
            titleAndData[imageName] = image

    print(titleAndData)


def test_upload():
    credential_location = os.path.dirname(os.path.realpath(__file__)) + "/credentials.json"
    lesson_folder_path = os.path.expanduser("~/Desktop/lessons")
    cred = credentials.Certificate(credential_location)

    # Initalize it and the storage bucket called lessons
    firebase_admin.initialize_app(cred)
    # Firebase Storage Bucket to place the image
    bucket = storage.bucket('makeshift-homeschool-281816.appspot.com')

    # Access Token metadata
    accessToken = uuid4()
    metadata = {"firebaseStorageDownloadTokens": accessToken}

    blob = bucket.blob('Personality Commander ENTJ.jpg')
    blob.metadata = metadata
    blob.upload_from_filename('/Users/weijiang/Desktop/Images for lessons/Personality Commander ENTJ.jpg')
    blob.generate_signed_url(expiration= , access_token=accessToken)



test_upload()
#generateMapWithLessonNameAndImageData()