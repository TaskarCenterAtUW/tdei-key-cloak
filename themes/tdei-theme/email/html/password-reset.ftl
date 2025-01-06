<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap"
        rel="stylesheet">
    <title>Password Reset Request</title>
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

                    <tr>
                        <td style="padding: 10px; border-bottom: 1px solid #873ef2; background: linear-gradient(135deg, rgba(44, 216, 219, 0.51) 0%, rgba(153, 89, 249, 0.36) 48%, rgba(71, 159, 161, 0.45) 100%); border-radius: 5px 5px 0px 0px; display: flex; align-items: center;">
                            <img src="https://transitequity.cs.washington.edu/wp-content/uploads/2023/05/TDEI_notext-1.png"
                                alt="TDEI Logo" style="max-width: 75px; height: auto;">
                            <p style="display: flex;align-items: center;font-weight: 700;font-size: 16px;color: #444;">${kcSanitize(msg("tdeiTitle"))?no_esc}</p>
                        </td>
                    </tr>

                    <tr>
                        <td style="padding: 20px; font-size: 15px; line-height: 1.5; color: #444;">
                            <p style="font-size: 22px; font-weight: 700; color: #873ef2; padding-bottom: 10px;">${kcSanitize(msg("passwordReset_titleMsg"))?no_esc}</p>
                            <p>${kcSanitize(msg("greetingMsg"))?no_esc} ${user.firstName},</p>
                            <p>${kcSanitize(msg("passwordReset_welcomeMsg"))?no_esc}</p>
                            <p style="text-align: center; margin: 30px 0px;">
                                <a href="${link}" style="background-color: #873ef2; color: #ffffff; padding: 12px 25px; text-decoration: none; border-radius: 5px; display: inline-block; font-size: 16px;">${kcSanitize(msg("passwordReset_button"))?no_esc}</a>
                            </p>
                            <p>${kcSanitize(msg("passwordReset_linkExpireMsg_01"))?no_esc} <span style="font-weight: 700;">${linkExpirationFormatter(linkExpiration)}</span>. ${kcSanitize(msg("passwordReset_linkExpireMsg_02"))?no_esc}</p>
                            <p>${kcSanitize(msg("passwordReset_ignoreMsg"))?no_esc}</p>
                            <p style="margin-top: 40px;">${kcSanitize(msg("passwordReset_signature"))?no_esc}<br>${kcSanitize(msg("tdeiTeam"))?no_esc}</p>  
                        </td>
                    </tr>
                    
                    <tr>
                        <td style="padding: 20px; font-size: 12px; text-align: left; color: #999;">
                            <hr style="border-top: 1px dashed #d5d5d5;border-bottom: none;margin-bottom: 20px;">
                            <p style="color: #999;">${kcSanitize(msg("copyURLMsg"))?no_esc}</p>
                            <p>
                                <a href="${link}" style="color: #007bff; text-decoration: none; overflow-wrap: anywhere;">${link}</a>
                            </p>
                        </td>
                    </tr>

                </table>
            </td>
        </tr>
    </table>

</body>

</html>