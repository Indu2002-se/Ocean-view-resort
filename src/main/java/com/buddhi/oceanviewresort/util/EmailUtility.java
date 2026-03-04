package com.buddhi.oceanviewresort.util;

import com.buddhi.oceanviewresort.model.entity.Bill;
import com.buddhi.oceanviewresort.model.entity.Reservation;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtility {

    // Configure your SMTP settings here
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";

    // Replace these placeholders with actual credentials
    private static final String SENDER_EMAIL = "resortocean300@gmail.com";
    private static final String SENDER_PASSWORD = "miekgmvujlvnwjsl";

    public static void sendBillEmail(String recipientEmail, String guestName, Bill bill, Reservation reservation) {
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", SMTP_HOST);
        properties.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL, "Ocean View Resort"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Your Bill - Ocean View Resort (" + reservation.getReservationNo() + ")");

            java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy");
            String checkInStr = reservation.getCheckInDate() != null ? reservation.getCheckInDate().format(formatter)
                    : "N/A";
            String checkOutStr = reservation.getCheckOutDate() != null ? reservation.getCheckOutDate().format(formatter)
                    : "N/A";
            String amountFormatted = String.format("%.2f", bill.getAmount());

            String emailContent = "<div style=\"font-family: 'Segoe UI', Arial, sans-serif; max-width: 600px; margin: 0 auto; background-color: #f4f6f9; padding: 40px 20px; border-radius: 10px;\">"
                    + "    <div style=\"text-align: center; margin-bottom: 30px;\">"
                    + "        <h1 style=\"color: #1a1a1a; margin: 0; font-size: 32px; font-weight: 700;\">ocean<span style=\"color: #c9a55c;\">.view</span></h1>"
                    + "        <p style=\"color: #7f8c8d; font-size: 12px; letter-spacing: 3px; text-transform: uppercase; margin-top: 5px;\">Guest Invoice</p>"
                    + "    </div>"
                    + "    <div style=\"background-color: #ffffff; padding: 40px; border-radius: 12px; box-shadow: 0 10px 20px rgba(0,0,0,0.05);\">"
                    + "        <h3 style=\"color: #2c3e50; margin-top: 0; font-size: 22px; font-weight: 600;\">Dear "
                    + guestName + ",</h3>"
                    + "        <p style=\"color: #555555; line-height: 1.8; font-size: 15px;\">Thank you for choosing <strong>Ocean View Resort</strong>. We hope you enjoyed your stay and had a relaxing, memorable experience with us.</p>"
                    + "        <p style=\"color: #555555; line-height: 1.8; font-size: 15px;\">Please find the details of your final bill below:</p>"
                    + "        "
                    + "        <table style=\"width: 100%; border-collapse: collapse; margin-top: 30px; margin-bottom: 30px;\">"
                    + "            <tr>"
                    + "                <td style=\"padding: 16px 12px; border-bottom: 1px solid #eeeeee; color: #555555; font-size: 15px;\"><strong>Reservation No</strong></td>"
                    + "                <td style=\"padding: 16px 12px; border-bottom: 1px solid #eeeeee; color: #2c3e50; text-align: right; font-size: 15px;\">"
                    + reservation.getReservationNo() + "</td>"
                    + "            </tr>"
                    + "            <tr>"
                    + "                <td style=\"padding: 16px 12px; border-bottom: 1px solid #eeeeee; background-color: #fafbfc; color: #555555; font-size: 15px;\"><strong>Check-In Date</strong></td>"
                    + "                <td style=\"padding: 16px 12px; border-bottom: 1px solid #eeeeee; background-color: #fafbfc; color: #2c3e50; text-align: right; font-size: 15px;\">"
                    + checkInStr + "</td>"
                    + "            </tr>"
                    + "            <tr>"
                    + "                <td style=\"padding: 16px 12px; border-bottom: 1px solid #eeeeee; color: #555555; font-size: 15px;\"><strong>Check-Out Date</strong></td>"
                    + "                <td style=\"padding: 16px 12px; border-bottom: 1px solid #eeeeee; color: #2c3e50; text-align: right; font-size: 15px;\">"
                    + checkOutStr + "</td>"
                    + "            </tr>"
                    + "            <tr>"
                    + "                <td style=\"padding: 20px 12px; font-weight: bold; font-size: 16px; color: #c9a55c; border-bottom: 2px solid #c9a55c;\">Total Amount Due</td>"
                    + "                <td style=\"padding: 20px 12px; font-weight: bold; font-size: 20px; color: #c9a55c; text-align: right; border-bottom: 2px solid #c9a55c;\">$"
                    + amountFormatted + "</td>"
                    + "            </tr>"
                    + "        </table>"
                    + "        "
                    + "        <p style=\"color: #555555; line-height: 1.8; font-size: 14px;\">If you have any questions or require further assistance regarding this invoice, please do not hesitate to contact our dedicated support team at <a href=\"mailto:support@oceanview.com\" style=\"color: #c9a55c; text-decoration: none; font-weight: 600;\">support@oceanview.com</a>.</p>"
                    + "        <p style=\"color: #555555; line-height: 1.8; font-size: 15px; margin-bottom: 0; margin-top: 30px;\">Best regards,<br><strong style=\"color: #2c3e50; font-size: 16px;\">Ocean View Resort Management</strong></p>"
                    + "    </div>"
                    + "    <div style=\"text-align: center; margin-top: 30px; color: #95a5a6; font-size: 12px;\">"
                    + "        <p>© " + java.time.Year.now() + " Ocean View Resort. All rights reserved.</p>"
                    + "    </div>"
                    + "</div>";

            message.setContent(emailContent, "text/html; charset=utf-8");

            Transport.send(message);
            System.out.println("Bill email sent successfully to " + recipientEmail);

        } catch (Exception e) {
            System.err.println("Failed to send bill email to " + recipientEmail);
            e.printStackTrace();
        }
    }
}
