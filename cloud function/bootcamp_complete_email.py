import datetime
import requests
import os
import json
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail


def send_lesson_deny_email(request):
    # request json body
    request_json = request.get_json()

    userData = request_json["data"]

    message = Mail(
        from_email=("joe@wequil.com", "Makeshift Homeschool Automated Message"),
        to_emails=(userData["email"], f"""Parent of {userData["username"]}"""),
        subject=f"""{userData["username"]} Completed a Bootcamp Lesson!""",
        html_content=f"""
            <p> Hello, parent of {userData["username"]}:</p>
            <br>
            <p> {userData["username"]} recently completed the bootcamp: </p>
            <p> <b>{userData["activityId"]}</b>. </p>
            <br>
            <p> Below is a copy of {userData["username"]}'s work. </p>
            <br>
            <p> {userData["userResponse"]}</p>
            <br>
            <p> Best,</p>
            <p> Makeshift Homeschool Team </p>
        """
    )
    sendgrid_client = SendGridAPIClient("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")
    sendgrid_client.send(message)