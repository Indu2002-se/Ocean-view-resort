<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.buddhi.oceanviewresort.model.entity.Reservation" %>
        <%@ page import="com.buddhi.oceanviewresort.model.entity.Bill" %>
            <%@ page import="java.time.format.DateTimeFormatter" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>View Bill - Ocean View Resort</title>
                    <!-- html2pdf library -->
                    <script
                        src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
                    <style>
                        * {
                            margin: 0;
                            padding: 0;
                            box-sizing: border-box;
                        }

                        body {
                            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                            background: #1a1a1a;
                            color: #fff;
                            min-height: 100vh;
                            display: flex;
                            justify-content: center;
                            align-items: center;
                            padding: 40px;
                        }

                        .bill-container {
                            width: 100%;
                            max-width: 800px;
                            background: #fff;
                            color: #1a1a1a;
                            border-radius: 8px;
                            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                            overflow: hidden;
                            position: relative;
                        }

                        .bill-content {
                            padding: 60px;
                        }

                        .bill-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: flex-start;
                            margin-bottom: 60px;
                            padding-bottom: 20px;
                            border-bottom: 2px solid #f0f0f0;
                        }

                        .company-info h1 {
                            font-size: 28px;
                            font-weight: 700;
                            margin-bottom: 5px;
                            color: #1a1a1a;
                            text-transform: lowercase;
                        }

                        .company-info h1 span {
                            color: #c9a55c;
                        }

                        .company-info p {
                            font-size: 13px;
                            color: #666;
                            margin-bottom: 3px;
                        }

                        .invoice-info {
                            text-align: right;
                        }

                        .invoice-title {
                            font-size: 32px;
                            color: #c9a55c;
                            text-transform: uppercase;
                            letter-spacing: 2px;
                            font-weight: 300;
                            margin-bottom: 10px;
                        }

                        .invoice-detail {
                            font-size: 13px;
                            color: #666;
                            margin-bottom: 5px;
                        }

                        .invoice-detail strong {
                            color: #1a1a1a;
                            font-weight: 600;
                            margin-right: 5px;
                        }

                        .bill-section {
                            display: flex;
                            justify-content: space-between;
                            margin-bottom: 40px;
                        }

                        .section-box h3 {
                            font-size: 11px;
                            text-transform: uppercase;
                            letter-spacing: 1px;
                            color: #999;
                            margin-bottom: 15px;
                            font-weight: 600;
                        }

                        .section-box p {
                            font-size: 14px;
                            line-height: 1.6;
                            color: #1a1a1a;
                            font-weight: 500;
                        }

                        .section-box .email {
                            color: #c9a55c;
                        }

                        .items-table {
                            width: 100%;
                            border-collapse: collapse;
                            margin-bottom: 40px;
                        }

                        .items-table th {
                            text-align: left;
                            padding: 15px 0;
                            font-size: 11px;
                            text-transform: uppercase;
                            color: #999;
                            border-bottom: 1px solid #eee;
                            font-weight: 600;
                        }

                        .items-table td {
                            padding: 20px 0;
                            font-size: 14px;
                            color: #1a1a1a;
                            border-bottom: 1px solid #f9f9f9;
                        }

                        .items-table .text-right {
                            text-align: right;
                        }

                        .items-table .total-row td {
                            border-top: 2px solid #c9a55c;
                            border-bottom: none;
                            padding-top: 20px;
                            font-weight: 700;
                            font-size: 16px;
                            color: #1a1a1a;
                        }

                        .items-table .total-row .grand-total {
                            font-size: 24px;
                            color: #c9a55c;
                        }

                        .bill-footer {
                            text-align: center;
                            margin-top: 60px;
                            padding-top: 30px;
                            border-top: 1px solid #f0f0f0;
                            color: #999;
                            font-size: 12px;
                        }

                        .actions-panel {
                            background: #0d0d0d;
                            padding: 20px;
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                        }

                        .back-link {
                            color: rgba(255, 255, 255, 0.6);
                            text-decoration: none;
                            font-size: 13px;
                            transition: color 0.3s;
                            display: flex;
                            align-items: center;
                            gap: 8px;
                        }

                        .back-link:hover {
                            color: #fff;
                        }

                        .btn-download {
                            background: #c9a55c;
                            color: #1a1a1a;
                            border: none;
                            padding: 12px 30px;
                            border-radius: 30px;
                            font-size: 12px;
                            font-weight: 600;
                            text-transform: uppercase;
                            letter-spacing: 1px;
                            cursor: pointer;
                            transition: all 0.3s;
                            display: flex;
                            align-items: center;
                            gap: 8px;
                        }

                        .btn-download:hover {
                            background: #dcb363;
                            transform: translateY(-2px);
                            box-shadow: 0 5px 15px rgba(201, 165, 92, 0.3);
                        }

                        @media print {
                            body {
                                background: #fff;
                                padding: 0;
                                color: #000;
                            }

                            .bill-container {
                                box-shadow: none;
                                max-width: 100%;
                                border-radius: 0;
                            }

                            .actions-panel {
                                display: none !important;
                            }

                            .bill-content {
                                padding: 40px;
                            }
                        }
                    </style>
                </head>

                <body>

                    <% Reservation r=(Reservation) request.getAttribute("reservation");

                    Bill b=(Bill)
                        request.getAttribute("bill");

                    DateTimeFormatter dateFmt=DateTimeFormatter.ofPattern("MMMM dd, yyyy");
                    if (r !=null && b !=null) {
                        long
                        nights=java.time.temporal.ChronoUnit.DAYS.between(r.getCheckInDate(), r.getCheckOutDate());

                        if
                        (nights < 1) nights=1; double subTotal=b.getTotalAmount() / 1.10; double tax=b.getTotalAmount()
                        - subTotal; %>

                        <div class="bill-container" id="invoiceElement">
                            <div class="bill-content">
                                <div class="bill-header">
                                    <div class="company-info">
                                        <h1>ocean<span>.view</span></h1>
                                        <p>123 Coastal Road, Galle, Sri Lanka</p>
                                        <p>+94 11 234 5678</p>
                                        <p>info@oceanviewresort.com</p>
                                    </div>
                                    <div class="invoice-info">
                                        <div class="invoice-title">Invoice</div>
                                        <div class="invoice-detail"><strong>Invoice #:</strong>
                                            <%= b.getBillId() %>
                                        </div>
                                        <div class="invoice-detail"><strong>Date:</strong>
                                            <%= b.getGeneratedDate().format(dateFmt) %>
                                        </div>
                                        <div class="invoice-detail"><strong>Status:</strong> <span
                                                style="color: #28a745;">Paid</span></div>
                                    </div>
                                </div>

                                <div class="bill-section">
                                    <div class="section-box">
                                        <h3>Bill To</h3>
                                        <p>
                                            <strong>
                                                <%= r.getGuestName() %>
                                            </strong><br>
                                            <%= r.getAddress() !=null ? r.getAddress() : "Address not provided" %><br>
                                                <%= r.getPhoneNo() %><br>
                                                    <span class="email">
                                                        <%= r.getGuestEmail() %>
                                                    </span>
                                        </p>
                                    </div>
                                    <div class="section-box" style="text-align: right;">
                                        <h3>Stay Details</h3>
                                        <p>
                                            <strong>Reservation:</strong> #<%= r.getReservationNo() %><br>
                                                <strong>Check-In:</strong>
                                                <%= r.getCheckInDate().format(dateFmt) %><br>
                                                    <strong>Check-Out:</strong>
                                                    <%= r.getCheckOutDate().format(dateFmt) %><br>
                                                        <strong>Nights:</strong>
                                                        <%= nights %> | <strong>Guests:</strong>
                                                            <%= r.getNumGuests() %>
                                        </p>
                                    </div>
                                </div>

                                <table class="items-table">
                                    <thead>
                                        <tr>
                                            <th>Description</th>
                                            <th class="text-right">Rate</th>
                                            <th class="text-right">Qty</th>
                                            <th class="text-right">Amount</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <strong>Room Charges</strong><br>
                                                <span style="font-size: 12px; color: #999;">
                                                    <%= r.getRoomTypeId()==1 ? "Standard Room" : r.getRoomTypeId()==2
                                                        ? "Deluxe Room" : r.getRoomTypeId()==3 ? "Suite"
                                                        : "Ocean View Suite" %>
                                                </span>
                                            </td>
                                            <td class="text-right">$<%= String.format("%.2f", subTotal/nights) %>
                                            </td>
                                            <td class="text-right">
                                                <%= nights %>
                                            </td>
                                            <td class="text-right">$<%= String.format("%.2f", subTotal) %>
                                            </td>
                                        </tr>
                                        <!-- Add more rows for services if needed -->

                                        <tr>
                                            <td colspan="3" class="text-right"
                                                style="padding-top: 30px; font-weight: 600; color: #666;">Subtotal</td>
                                            <td class="text-right" style="padding-top: 30px;">$<%= String.format("%.2f",
                                                    subTotal) %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" class="text-right" style="font-weight: 600; color: #666;">
                                                Tax (10%)</td>
                                            <td class="text-right">$<%= String.format("%.2f", tax) %>
                                            </td>
                                        </tr>
                                        <tr class="total-row">
                                            <td colspan="3" class="text-right">Total Amount</td>
                                            <td class="text-right grand-total">$<%= String.format("%.2f",
                                                    b.getTotalAmount()) %>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                                <div class="bill-footer">
                                    <p>Thank you for choosing Ocean View Resort. We hope to see you again soon!</p>
                                    <p style="margin-top: 10px; font-size: 11px;">For inquiries, contact us at info@oceanviewresort.com or +94 11 234 5678</p>
                                </div>
                            </div>

                            <div class="actions-panel" data-html2canvas-ignore="true">
                                <a href="<%= request.getContextPath() %>/bill-servlet" class="back-link">
                                    ← Back to Billing
                                </a>
                                <button onclick="downloadPDF()" class="btn-download">
                                    Download PDF ↓
                                </button>
                            </div>
                        </div>

                        <% } else { %>
                            <div style="text-align: center; color: rgba(255,255,255,0.7);">
                                <h2>Bill Not Found</h2>
                                <p>The requested bill details could not be loaded.</p>
                                <p style="font-size: 12px; color: #dc3545; margin-top: 10px;">
                                    Debug: Reservation is <%= r==null ? "NULL" : "FOUND" %>,
                                        Bill is <%= b==null ? "NULL" : "FOUND" %>
                                </p>
                                <p>Reservation No: <%= request.getParameter("reservationNo") %>
                                </p>
                                <br>
                                <a href="<%= request.getContextPath() %>/bill-servlet" style="color: #c9a55c;">Return
                                    to Billing</a>
                            </div>
                            <% } %>

                                <script>
                                    function downloadPDF() {
                                        const element = document.querySelector('.bill-content');
                                        const opt = {
                                            margin: 0,
                                            filename: 'Invoice_<%= b != null ? b.getBillId() : "OceanView" %>.pdf',
                                            image: { type: 'jpeg', quality: 0.98 },
                                            html2canvas: { scale: 2 },
                                            jsPDF: { unit: 'in', format: 'letter', orientation: 'portrait' }
                                        };

                                        // Choose the element that we want to render as PDF
                                        // We select .bill-content to exclude the footer button bar
                                        html2pdf().set(opt).from(element).save();
                                    }
                                </script>
                </body>

                </html>