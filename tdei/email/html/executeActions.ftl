<#outputformat "plainText">
<#assign requiredActionsText><#if requiredActions??><#list requiredActions><#items as reqActionItem>${msg("requiredAction.${reqActionItem}")}<#sep>, </#sep></#items></#list></#if></#assign>
</#outputformat>

<#import "template.ftl" as layout>
<@layout.emailLayout>
<#if requiredActions?seq_contains("VERIFY_EMAIL")>
${kcSanitize(msg("executeActionsBodyHtml_VERIFY_EMAIL",link, linkExpiration, realmName, requiredActionsText, linkExpirationFormatter(linkExpiration)))?no_esc}
</#if>
<#if requiredActions?seq_contains("UPDATE_PASSWORD")>
${kcSanitize(msg("executeActionsBodyHtml_UPDATE_PASSWORD",link, linkExpiration, realmName, requiredActionsText, linkExpirationFormatter(linkExpiration)))?no_esc}
</#if>
</@layout.emailLayout>