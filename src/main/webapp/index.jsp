<%@page import="org.pac4j.core.exception.RequiresHttpAction"%>
<%@page import="org.pac4j.springframework.security.authentication.*"%>
<%@page import="org.springframework.security.core.*"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.pac4j.core.context.*"%>
<%@page import="org.pac4j.core.profile.*"%>
<%@page import="org.pac4j.http.client.*"%>
<%@page import="org.pac4j.oauth.client.*"%>
<%@page import="org.pac4j.cas.client.*"%>
<%@page import="org.pac4j.saml.client.*"%>
<%
	WebContext context = new J2EContext(request, response); 
	FacebookClient fbClient = (FacebookClient) application.getAttribute("FacebookClient");
	TwitterClient twClient = (TwitterClient) application.getAttribute("TwitterClient");
	FormClient formClient = (FormClient) application.getAttribute("FormClient");
	BasicAuthClient baClient = (BasicAuthClient) application.getAttribute("BasicAuthClient");
	CasClient casClient = (CasClient) application.getAttribute("CasClient");
	Saml2Client saml2Client = (Saml2Client) application.getAttribute("Saml2Client");
%>
<h1>index</h1>
<a href="facebook/index.jsp">Protected url by Facebook : facebook/index.jsp</a><br />
<a href="twitter/index.jsp">Protected url by Twitter : twitter/index.jsp</a><br />
<a href="google/index.jsp">Protected url by Google : google/index.jsp</a><br />
<a href="form/index.jsp">Protected url by form authentication : form/index.jsp</a><br />
<a href="basicauth/index.jsp">Protected url by basic auth : basicauth/index.jsp</a><br />
<a href="cas/index.jsp">Protected url by CAS : cas/index.jsp</a><br />
<a href="saml/index.jsp">Protected url by SAML : saml/index.jsp</a><br />
<br />
<a href="/j_spring_security_logout">logout</a>
<br /><br />
<%Authentication auth = (Authentication) SecurityContextHolder.getContext().getAuthentication();
UserProfile profile = null;
if (auth != null && auth instanceof ClientAuthenticationToken) {
    ClientAuthenticationToken token = (ClientAuthenticationToken) auth; 
    profile = token.getUserProfile();
}
%>
profile : <%=profile%>
<br /><br />
<hr />
<%
try {
%>
<a href="<%=fbClient.getRedirectAction(context, false, false).getLocation()%>">Authenticate with Facebook</a><br />
<a href="<%=twClient.getRedirectAction(context, false, false).getLocation()%>">Authenticate with Twitter</a><br />
<a href="<%=formClient.getRedirectAction(context, false, false).getLocation()%>">Authenticate with form</a><br />
<a href="<%=baClient.getRedirectAction(context, false, false).getLocation()%>">Authenticate with basic auth</a><br />
<a href="<%=casClient.getRedirectAction(context, false, false).getLocation()%>">Authenticate with CAS</a><br />
<a href="<%=saml2Client.getRedirectAction(context, false, false).getLocation()%>">Authenticate with SAML</a><br />
<%
} catch (RequiresHttpAction e) {
	// should not happen
}
%>
