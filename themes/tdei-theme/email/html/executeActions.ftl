<#outputformat "plainText">
<#assign requiredActionsText><#if requiredActions??><#list requiredActions><#items as reqActionItem>${msg("requiredAction.${reqActionItem}")}<#sep>, </#sep></#items></#list></#if></#assign>
</#outputformat>

<#import "template.ftl" as layout>
<@layout.emailLayout>
    <tr>
        <td style="padding: 10px; border-bottom: 1px solid #873ef2; background: linear-gradient(135deg, rgba(44, 216, 219, 0.51) 0%, rgba(153, 89, 249, 0.36) 48%, rgba(71, 159, 161, 0.45) 100%); border-radius: 5px 5px 0px 0px; display: flex; align-items: center;">
            <img src="https://transitequity.cs.washington.edu/wp-content/uploads/2023/05/TDEI_notext-1.png"
                alt="TDEI Logo" style="max-width: 75px; height: auto;">
            <p style="display: flex;align-items: center;font-weight: 700;font-size: 16px;color: #444;">${kcSanitize(msg("tdeiTitle"))?no_esc}</p>
        </td>
    </tr>
    <#if requiredActions?seq_contains("VERIFY_EMAIL")>
        <tr>
            <td style="padding: 20px; font-size: 15px; line-height: 1.5; color: #444;">
                <p>${kcSanitize(msg("greetingMsg"))?no_esc} ${user.firstName},</p>
                <p>${kcSanitize(msg("verifyEmail_welcomeMsg"))?no_esc}</p>
                <p style="text-align: left; margin: 30px 0px;">
                    <a href="${link}" style="background-color: #873ef2; color: #ffffff; padding: 12px 25px; text-decoration: none; border-radius: 5px; display: inline-block; font-size: 16px;">${kcSanitize(msg("verifyEmail_button"))?no_esc}</a>
                </p>
                <p>${kcSanitize(msg("verifyEmail_linkExpireMsg"))?no_esc} <span style="font-weight: 700;">${linkExpirationFormatter(linkExpiration)}</span>.</p>
                <p>${kcSanitize(msg("verifyEmail_helpMsg"))?no_esc}</p>
                <p>${kcSanitize(msg("verifyEmail_ignoreMsg"))?no_esc}</p>
                <p style="margin-top: 40px;">${kcSanitize(msg("verifyEmail_signature"))?no_esc}<br>${kcSanitize(msg("tdeiTeam"))?no_esc}</p>  
            </td>
        </tr>
    <#elseif requiredActions?seq_contains("UPDATE_PASSWORD")>
        <tr>
            <td style="padding: 20px; font-size: 15px; line-height: 1.5; color: #444;">
                <p style="font-size: 22px; font-weight: 700; color: #873ef2; padding-bottom: 10px;">${kcSanitize(msg("passwordReset_titleMsg"))?no_esc}</p>
                <p>${kcSanitize(msg("greetingMsg"))?no_esc} ${user.firstName},</p>
                <p>${kcSanitize(msg("passwordReset_welcomeMsg"))?no_esc}</p>
                <p style="text-align: left; margin: 30px 0px;">
                    <a href="${link}" style="background-color: #873ef2; color: #ffffff; padding: 12px 25px; text-decoration: none; border-radius: 5px; display: inline-block; font-size: 16px;">${kcSanitize(msg("passwordReset_button"))?no_esc}</a>
                </p>
                <p>${kcSanitize(msg("passwordReset_linkExpireMsg_01"))?no_esc} <span style="font-weight: 700;">${linkExpirationFormatter(linkExpiration)}</span>. ${kcSanitize(msg("passwordReset_linkExpireMsg_02"))?no_esc}</p>
                <p>${kcSanitize(msg("passwordReset_ignoreMsg"))?no_esc}</p>
                <p style="margin-top: 40px;">${kcSanitize(msg("passwordReset_signature"))?no_esc}<br>${kcSanitize(msg("tdeiTeam"))?no_esc}</p>  
            </td>
        </tr>
    <#else>
        ${kcSanitize(msg("executeActionsBodyHtml",link, linkExpiration, realmName, requiredActionsText, linkExpirationFormatter(linkExpiration)))?no_esc}
    </#if> 
    <tr>
        <td style="padding: 20px; font-size: 12px; text-align: left; color: #999;">
            <hr style="border-top: 1px dashed #d5d5d5;border-bottom: none;margin-bottom: 20px;">
            <p style="color: #999;">${kcSanitize(msg("copyURLMsg"))?no_esc}</p>
            <p>
                <a href="${link}" style="color: #007bff; text-decoration: none; word-break: break-all; overflow-wrap: anywhere;">${link}</a>
            </p>
        </td>
    </tr>

<#-- ${kcSanitize(msg("executeActionsBodyHtml",link, linkExpiration, realmName, requiredActionsText, linkExpirationFormatter(linkExpiration)))?no_esc} -->
</@layout.emailLayout>
