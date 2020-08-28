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
        from_email= ("hello@MakeshiftHomeschool.com", "Makeshift Homeschool Automated Message"),
        to_emails= (userData["email"], userData["username"]),
        subject= "Your Lesson was Denied",
        html_content= f"""
            <p> Hello, {userData["username"]}</p>
            <br>
            <p> Your lesson, {userData["lessonTitle"]}, was denied. </p>
            <p> Please review your lesson again </p>
            
        """
    )
    sendgrid_client = SendGridAPIClient("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")
    sendgrid_client.send(message)






def send_email_every_min(request):
    if request.method == 'GET':
        
        DATE = datetime.datetime.now().strftime("%I:%M %p on %m/%d/%Y")
        #gives the format: hh:mmAM/PM MMDDYY

        SENDGRID_API_KEY = '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'

        to_emails = [
            ('wjiangck@gmail.com', 'Wei'),
            ('joe@wequil.com', 'Joeseph'),
            ('joseph.e.mcphail@gmail.com', 'Joseph'),
            ('lihong.l.mcphail@gmail.com', 'Lihong')
        ]
        message = Mail(
            from_email=('joe@wequil.com', 'WEquil Cloud Function'),
            to_emails=to_emails,
            subject='Testing Cloud Scheduler Function',
            html_content=f"""
                <p> Hello from the cloud:</p>
                <br>
                <br>
                <p> 	Current email send at {DATE}</p>
                <br>
                <p> 	Wait another minute for the next email!</p>
                <br>
                <p> Best, </p>
                <p>Your Google Cloud Function</p>

            """
        )
        try:
            sendgrid_client = SendGridAPIClient("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")
            response = sendgrid_client.send(message)
            print(response.status_code)
            print(response.body)
            print(response.headers)
            return "DONE"
        except Exception as e:
            return e