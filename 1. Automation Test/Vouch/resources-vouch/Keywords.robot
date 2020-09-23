Resource                           ../PageImporter.robot

*** Variable ***
${ALL_ADS_CLOSER_ELEMENT}          [data-info="ad"]
${ARTICLE_IRIDESCENT_LIST_ITEM}    .articles--iridescent-list--item
${ARTICLE_IRIDESCENT_LIST}         .articles--iridescent-list
${ARTICLES_LOADING_ANIMATION}      .articles--index-button__loading-animation
${ARTICLE_TEXT_ITEM}               .articles--iridescent-list--text-item
${ARTICLE_TEXT_ITEM_TITLE}         .articles--iridescent-list--text-item__title
${ARTICLE_TEXT_ITEM_TITLE_LINK}    .articles--iridescent-list--text-item__title-link
${AUTHENTICATION_LOGIN}            .authentication--login
${BREAKING_NEWS}                   breaking-news
${BREAKING_NEWS_CLOSER}            .breaking-news__close
${CALENDAR}                        \#ui-datepicker-div
${CALENDER_FIELD}                  .articles-filter__date-selector
${COMMENT_LOGIN}                   \#comment-login
${DROPDOWN_USER}                   \#dropdown-user
${DROPDOWN_USER_MENU}              .dropdown-menu.navbar--top--user-dropdown__menu
${DROPDOWN_USER_MENU_ITEM}         .navbar--top--user-dropdown__menu-item
${DATEPICKER_DATE}                 .ui-state-default
${DATEPICKER_MONTH}                .ui-datepicker-month
${DATEPICKER_YEAR}                 .ui-datepicker-year
${FEED_ERROR_LEFT}                 document.getElementsByClassName("liputan6-error-left")
${FEED_ERROR_RIGHT}                document.getElementsByClassName("liputan6-error-right")
${FEED_LINE_ELEMENT}               document.getElementsByTagName("UUID")[0].innerHTML
${GOOGLE_IFRAME_ADS}               div[id^="google_ads_iframe"]
${GOOGLE_PASSWORD_FIELD}           document.getElementsByName("password")[0]
${GOOGLE_PASSWORD_NEXT_BUTTON}     passwordNext
${IDENTIFIER_ID}                   identifierId
${IDENTIFIER_NEXT}                 identifierNext
${LOGIN}                           .login
${LOGIN_LINK_MENU}                 \#login
${LOGOUT}                          .logout
${PAGINATION_CONTAINER}            .simple-pagination__container
${PAGINATION_NEXT_LINK}            .simple-pagination__next-link
${PAGINATION_PREV_LINK}            .simple-pagination__prev-link
${PUSH_NOTIF}                      .onesignal-popover-dialog
${PUSH_NOTIF_DECLINE}              .align-right.secondary.popover-button
${RSS_CONTAINER}                   .pretty-print
${RSS_ELEMENT}                     document.getElementsByTagName("rss")[0]
${SITE_LOGO}                       .navbar--top--logo__link
${SOSMED_LOGIN_BUTTON}             .authentication--login__social-media a
${USER_AVATAR}                     .navbar--top--user-dropdown__avatar.avatar

*** Keywords ***
###################### GETTER ##########################
Iridescent List Length
    ${length}                                Execute Javascript                                                return $('${ARTICLE_IRIDESCENT_LIST}').length
    [Return]                                 ${length}

Multiple Page Length
    ${length}                                Execute Javascript                                                return $('${MULTIPLE_PAGE_ARTICLE}').length
    [Return]                                 ${length}

TextType Article Length
    ${rowarticle}                            Execute Javascript                                                return $('${ARTICLE_TEXT_ITEM_TITLE}').length
    [Return]                                 ${rowarticle}

Get Href Without Parameter
    [Arguments]                              ${headline_href}
    #${headline_href}=                           Execute Javascript                                    return window.location.href;
    ${article_href_new_format}=              Fetch From Left                                                   ${headline_href}                                                          ?
    [Return]                                 ${article_href_new_format}


###################### OPEN BROWSER ##########################
VirtualDisplay
    Start Virtual Display                    2560                                                              1440

 Keywords.Push Notif Closer

Open Browser To Login Page
    [Timeout]                                30 Second
    Open Browser                             ${LOGIN URL}                                                      ${BROWSER}
    #Execute Javascript                       window.stop()
    Sleep                                    5
    Keywords.Push Notif Closer


Open Browser With Blank URL
    [Timeout]                                120 Second
    Open Browser                             about:blank                                                       ${BROWSER}
    Sleep                                    5
    Keywords.Push Notif Closer


###################### WINDOW SCROLL ##########################
Scroll To Element
    [Arguments]                              ${element}
    Wait Until Page Contains Element         ${element}                                                        timeout=3                                                                 error=There's no ${element}
    ${ver}=                                  Get Vertical Position                                             ${element}
    Execute Javascript                       window.scrollTo(0,${ver}-90)
    Sleep                                    1

Scroll To Top Page
    Execute Javascript                       window.scrollTo(0, 0);

Scroll To Bottom Page
    Execute Javascript                       window.scrollTo(0, document.body.scrollHeight);
    Sleep                                    2

Scroll Until Element Is Clickable
    [Arguments]                              ${element}
    Wait Until Element Is Visible            ${element}                                                        timeout=10                                                                error=There's no ${element}
    ${ver}=                                  Get Vertical Position                                             ${element}
    ${dec}=                                  Evaluate                                                          50
    Keywords.Scroll To Top Page
    :FOR  ${i}  IN RANGE  100
    \    Execute Javascript                  window.scrollTo(0,${ver}-${dec})
    \    ${status}                           ${value}=                                                         Run Keyword And Ignore Error                                              Click Link                                                         ${element}
    \    Run Keyword If                      '${status}' == 'PASS'                                             Exit For Loop
    \    ${dec}=                             Evaluate                                                          ${dec}+50


Scroll To Element With Parameters
    [Arguments]                              ${element}                                                        ${vertical}
    Wait Until Page Contains Element         ${element}                                                        timeout=3                                                                 error=There's no ${element}
    ${ver}=                                  Get Vertical Position                                             ${element}
    Execute Javascript                       window.scrollTo(0,${ver}-${vertical})
    Sleep                                    2

###################### LOGIN AS & LOGOUT ##########################
Login
    Wait Until Element Is Visible            sizzle=${AUTHENTICATION_LOGIN}
    Input Text                               username                                                          ${VALID USER}
    Input Password                           password                                                          ${VALID PASSWORD}
    Click Button                             Masuk
    Page Should Contain Element              sizzle=${USER_AVATAR}
    Keywords.Verify Page After Login

Click Social Media Login Button
    [Arguments]                              ${social_media_type}
    Click Element                            sizzle=${SOSMED_LOGIN_BUTTON}:contains("${social_media_type}")
    Sleep                                    1
    Run Keyword If                           '${social_media_type}'=='Facebook'                                Location Should Contain                                                   www.facebook.com
    ...                                      ELSE IF                                                           '${social_media_type}'=='Google'                                          Location Should Contain                                            https://accounts.google.com/

Input Facebook Login Attribute
    Input Text                               email                                                             ${EMAIL_FACEBOOK}
    Input Text                               pass                                                              ${PASSWORD_FACEBOOK}

Click Facebook Login Button
    ${check}                                 ${value} =                                                        Run Keyword And Ignore Error                                              Click Button                                                       Masuk
    Run Keyword If                           '${check}' == 'FAIL'                                              Click Button                                                              Log In

Input And Submit Google+ Login Attribute
    Wait Until Element Is Visible            id=${IDENTIFIER_ID}
    Input Text                               id=${IDENTIFIER_ID}                                               ${EMAIL_GOOGLE}
    Sleep                                    3
    Click Element                            id=${IDENTIFIER_NEXT}
    Sleep                                    3
    ${current_location}=                     Get Location
    Input Text                               dom=${GOOGLE_PASSWORD_FIELD}                                      ${PASSWORD_GOOGLE}
    Sleep                                    3
    Click Element                            id=${GOOGLE_PASSWORD_NEXT_BUTTON}
    Sleep                                    3

Verify Page After Login
    Page Should Not Contain                  sizzle=${LOGIN_LINK_MENU}
    Wait Until Element Is Visible            sizzle=${USER_AVATAR}                                             timeout=15

Login with Editor
    Sleep                                    1
    Wait Until Element Is Visible            sizzle=${AUTHENTICATION_LOGIN}
    Input Text                               username                                                          qaedit
    Input Password                           password                                                          Senayan14
    Click Button                             Masuk
    sleep                                    1

Go To Login Page
    Click Element                            sizzle=\#login
    Location Should Contain                  /login
    Wait Until Element Is Visible            sizzle=${AUTHENTICATION_LOGIN}                                    timeout=15

Login with Admin
    Keywords.Go To Login Page
    Wait Until Element Is Visible            sizzle=${AUTHENTICATION_LOGIN}
    Input Text                               username                                                          ${VALID USER}
    Input Password                           password                                                          ${VALID PASSWORD}
    Click Button                             Masuk
    Click Link                               sizzle=${DROPDOWN_USER}

Login with Tag Manager
    Sleep                                    1
    Wait Until Element Is Visible            sizzle=${AUTHENTICATION_LOGIN}
    Input Text                               username                                                          qagtm
    Input Password                           password                                                          Senayan14
    Click Button                             Masuk
    sleep                                    1

Logout
    Sleep                                    0.5
    Keywords.Click User Menu                 Keluar
    Keywords.Verify Page After Logout

Verify Page After Logout
    Page Should Not Contain Element          sizzle=${USER_AVATAR}
    Wait Until Element Is Visible            sizzle=${LOGIN}                                                   timeout=15
    Location Should Be                       ${HOME URL}

###################### USER MENU ##########################
Open Drop Down Menu
    Wait Until Element Is Visible            sizzle=${DROPDOWN_USER} img                                       timeout=30
    Location Should Contain                  ${HOME URL}

Click User Menu
    [Arguments]                              ${user_menu}
    Keywords.Push Notif Closer
    Mouse Over                               sizzle=${DROPDOWN_USER}
    Wait Until Element Is Visible            sizzle=${DROPDOWN_USER_MENU}                                      timeout=10
    ${href_user_menu}=                       ProfilePage.Get User Menu Href                                    ${user_menu}
    Click Link                               ${user_menu}
    Sleep                                    1
    Run Keyword If                           '${user_menu}'=='Keluar'                                          Location Should Be                                                        ${HOME_URL}
    ...                                      ELSE                                                              Location Should Be                                                        https:${href_user_menu}

###################### Feed ##########################
Open RSS
    Go To                                    ${HOME URL}rss
    Wait Until Element Is Visible            css=${RSS_CONTAINER}                                              timeout=30
    Wait Until Page Contains Element         dom=${RSS_ELEMENT}
    #Page Should Not Contain                  http

Go To Feed Page
    [Arguments]                              ${feed}
    Go To                                    ${feed}
    Page Should contain                      <description>
    Page Should Not Contain Element          dom=${FEED_ERROR_LEFT}
    Page Should Not Contain Element          dom=${FEED_ERROR_RIGHT}
    #Page Should Not Contain                  http

Verify Facebook Feed Page
    Page Should Contain                      <item>
    Page Should Contain                      xmlns:content="http://purl.org/rss/1.0/modules/content/

Verify Line Feed Page
    Page Should Contain                      <article>
    Page Should Contain Element              dom=${FEED_LINE_ELEMENT}
    ${href}=                                 Execute Javascript                                                return ${FEED_LINE_ELEMENT}
    ${href}=                                 Get Substring                                                     ${href}                                                                   start=0                                                            end=7
    Should Be True                           '${href}' == 'liputan'

Verify BBM Feed Page
    Page Should Contain                      xmlns:bbm="http://news.bbm.com/rss
    Page Should Contain                      <item>

###################### ADS CHECKER ##########################
Google Iframe Ads
    Wait Until Element Is Visible            sizzle=${GOOGLE_IFRAME_ADS}                                       timeout=2

All Ads Closer
    #Run Keyword And Ignore Error             Execute Javascript                                                $('${ALL_ADS_CLOSER_ELEMENT}').remove()
    Run Keyword And Ignore Error             Execute Javascript                                                let ads = document.querySelectorAll('[data-info="ad"]');                  ads.forEach(function(element, index) {element.innerHTML = '';})
    ${status_ads}                            ${value} =                                                        Run Keyword And Ignore Error                                              Keywords.Google Iframe Ads
    Run Keyword If                           '${status_ads}' == 'PASS'                                         Execute Javascript                                                        $('${GOOGLE_IFRAME_ADS}').remove();

###################### PUSH NOTIF ##########################
Push Notif
    Wait Until Element Is Visible            sizzle=${PUSH_NOTIF}                                              timeout=2

Push Notif Closer
    Run Keyword And Ignore Error             Click Element                                                     sizzle=${PUSH_NOTIF_DECLINE}
    Sleep                                    1

BreakingNews Closer
    Keywords.Scroll To Top Page
    ${status}                                ${value}=                                                         Run Keyword And Ignore Error                                              Wait Until Element Is Visible                                      id=${BREAKING_NEWS}                                     timeout=20
    Run Keyword If                           '${status}' == 'PASS'                                             Click Element                                                             sizzle=${BREAKING_NEWS_CLOSER}

Window Check
    ${width}                                 ${height} =                                                       Get Window Size
    Run Keyword If                           ${width}<1000                                                     Maximize Browser Window

###################### PICK ONE ARTICLE ##########################
Pick One Article
    ${rowarticle}=                           Keywords.TextType Article Length
    Keywords.All Ads Closer
    :FOR  ${i}  IN RANGE  ${rowarticle}
    \    ${chlocation}=                      Get Location
    \    Wait Until Page Contains Element    sizzle=${ARTICLE_TEXT_ITEM_TITLE} a:nth(${i})
    \    ${adurl}=                           Execute Javascript                                                return $('${ARTICLE_TEXT_ITEM_TITLE} a:nth(${i})').attr('href')
    \    ${adurl}=                           Get Substring                                                     ${adurl}                                                                  8                                                                  15
    \    Run Keyword If                      '${adurl}' != 'adclick'                                           Run Keywords
    ...                                      Keywords.Scroll Until Element Is Clickable                        sizzle=${ARTICLE_TEXT_ITEM_TITLE} a:nth(${i})                             AND
    ...                                      Exit For Loop
    \    ${articleLoc}=                      Get Location
    \    Run Keyword If                      '${chlocation}' != '${articleLoc}'                                Run Keywords
    ...                                      Go Back                                                           AND
    ...                                      Keywords.All Ads Closer
    Keywords.All Ads Closer

Pick One Random Article
    ${rowarticle}=                           Keywords.TextType Article Length
    Keywords.All Ads Closer
    :FOR  ${i}  IN RANGE  ${rowarticle}
    \    ${index}=                           Evaluate                                                          random.randint(1,3)                                                       modules=random, sys
    \    ${adurl}=                           Execute Javascript                                                return $('${ARTICLE_TEXT_ITEM_TITLE_LINK}:nth(${index})').attr("href")
    \    ${adurl}=                           Get Substring                                                     ${adurl}                                                                  8                                                                  15
    \    Run Keyword If                      '${adurl}' != 'adclick'                                           Run Keywords                                                              Keywords.Scroll Until Element Is Clickable                         sizzle=${ARTICLE_TEXT_ITEM_TITLE_LINK}:nth(${index})    AND
    ...                                      Exit For Loop
    Keywords.All Ads Closer

###################### SET CALENDAR ##########################
Pick Date
    Wait Until Element Is Visible            sizzle=${CALENDER_FIELD}                                          timeout=10
    Click Element                            date
    Wait Until Element Is Visible            sizzle=${CALENDAR}                                                timeout=60
    Click Element                            sizzle=${DATEPICKER_YEAR}
    Sleep                                    1
    Select From List By Value                sizzle=${DATEPICKER_YEAR}                                         2016
    Click Element                            sizzle=${DATEPICKER_MONTH}
    Sleep                                    1
    Select From List By Value                sizzle=${DATEPICKER_MONTH}                                        7
    Click Link                               sizzle=${DATEPICKER_DATE}:nth(0)

###################### PAGINATION ##########################
Check And Click Pagination Number Link
    Keywords.Scroll To Bottom Page
    ${status}                                ${value}=                                                         Run Keyword And Ignore Error                                              Wait Until Element Is Visible                                      sizzle=${PAGINATION_CONTAINER}                          timeout=15
    Run Keyword If                           '${status}' == 'PASS'                                             Run Keywords
    ...                                      Click Link                                                        sizzle=${PAGINATION_NEXT_LINK}                                            AND
    ...                                      Location Should Contain                                           page=2                                                                    AND
    ...                                      Keywords.Scroll To Element                                        sizzle=${PAGINATION_CONTAINER}                                            AND
    ...                                      Wait Until Element Is Visible                                     sizzle=${PAGINATION_CONTAINER}                                            timeout=15                                                         AND
    ...                                      Keywords.All Ads Closer                                           AND
    ...                                      Click Link                                                        sizzle=${PAGINATION_PREV_LINK}                                            AND
    ...                                      Location Should Contain                                           page=1
    Keywords.Scroll To Top Page

Scroll To Loading Animation
    #Execute Javascript                       $('html, body').animate({scrollTop:$('.articles--index-button__loading-animation').offset().top}, 200)
    Keywords.Scroll To Element               sizzle=${ARTICLES_LOADING_ANIMATION}
    Sleep                                    1
