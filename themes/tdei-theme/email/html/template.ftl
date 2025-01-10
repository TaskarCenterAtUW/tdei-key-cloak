<#macro emailLayout>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
    <style>
        body,
        table,
        td,
        a {
            margin: 0;
            padding: 0;
            text-size-adjust: none;
        }

        table {
            border-spacing: 0;
        }

        img {
            border: 0;
            line-height: 0;
            outline: none;
            text-decoration: none;
        }
    </style>
</head>
<body style="background-color: #f4f4f4; font-family: 'Open Sans', 'Roboto', Arial, sans-serif; color: #333; padding: 0; margin: 0;">
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0"
        style="background-color: #f4f4f4; padding: 20px 0;">
        <tr>
            <td align="center">
                <table role="presentation" width="600" cellpadding="0" cellspacing="0"
                    style="background-color: #ffffff; border-radius: 5px; box-shadow: 0 0px 8px rgba(0, 0, 0, 0.1);">

                    <#nested>

                </table>
            </td>
        </tr>
    </table>
</body>
</html>
</#macro>
