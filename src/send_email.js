"use strict";
const nodemailer = require("nodemailer");

const sendContact = (req, res) => {
    console.log(req.query)

  // create reusable transporter object using the default SMTP transport
  let transporter = nodemailer.createTransport({
    host: "smtp-mail.outlook.com", // This is the one for outlook
    secureConnection: false, // TLS requires secureConnection to be false
    port: 587, // port for secure SMTP
    tls: {
       ciphers:'SSLv3'
    },
    auth: {
      user: process.env.email_username, // saved username
      pass: process.env.email_password, // saved username
    },
  });

  const generateMessage = () => {
      let toReturn = "<p>";
      if (req.query.email !== "false") {
          toReturn = `A message has been sent from: <b>${req.query.email}</b>`
      } else {
          toReturn = "No response was requested."
      }
      toReturn += `<br/> <br/> The message body is listed below: <br/> </br> <b>${req.query.message}</b></p> `;
      console.log(toReturn)
      return toReturn;
  }

  const mailOptions = {
    from: process.env.email_username, // sender address - this should be the SWS email or someting of the like
    to: process.env.email_username, // send back to same email
    subject: process.env.email_contact_us_subjectLine, // Subject line
    html: generateMessage(), // html body
    replyTo: (req.query.email === "false") ? null : req.query.email,
  }
  
  // send mail with defined transport object
  transporter.sendMail(mailOptions, function(error, info){
    if(error){
        console.log(error);
        res.send({
            status: 400, 
            message: process.env.email_error,
        })
        return;
    }
        res.send({
            status: 200, 
            message: process.env.email_contact_us_response,
        });
        console.log('Message sent: ' + info.response);
        console.log("Message sent: %s", info.messageId);
    });

}
// sendContact(); // For immediate testing this function

module.exports = sendContact; 