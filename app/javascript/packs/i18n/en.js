I18n.translations || (I18n.translations = {});
I18n.translations["en"] = I18n.extend((I18n.translations["en"] || {}), {"about_us":"About us","activerecord":{"attributes":{"doorkeeper/application":{"name":"Name","redirect_uri":"Redirect URI"},"post":{"body":"Текст статті","title":"Заголовок"}},"errors":{"messages":{"record_invalid":"Validation failed: %{errors}","restrict_dependent_destroy":{"has_many":"Cannot delete record because dependent %{record} exist","has_one":"Cannot delete record because a dependent %{record} exists"}},"models":{"doorkeeper/application":{"attributes":{"redirect_uri":{"forbidden_uri":"is forbidden by the server.","fragment_present":"cannot contain a fragment.","invalid_uri":"must be a valid URI.","relative_uri":"must be an absolute URI.","secured_uri":"must be an HTTPS/SSL URI."}}}}}},"admin":"Admin","back":"Back","cancel":"Cancel","change":"Change","change_password":"Change password","choose_file":"Choose file","click_the_link_below_to_unlock_your_account":"Click the link below to unlock your account:","comparisons":"Comparisons","confirm_my_account":"Confirm my account","confirmation":"Are you sure?","created_at":"Created at","date":{"abbr_day_names":["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],"abbr_month_names":[null,"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"day_names":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],"formats":{"default":"%Y-%m-%d","long":"%B %d, %Y","short":"%b %d"},"month_names":[null,"January","February","March","April","May","June","July","August","September","October","November","December"],"order":["year","month","day"]},"datetime":{"distance_in_words":{"about_x_hours":{"few":"близько %{count} години","many":"близько %{count} годин","one":"about 1 hour","other":"about %{count} hours"},"about_x_months":{"few":"близько %{count} місяців","many":"близько %{count} місяців","one":"about 1 month","other":"about %{count} months"},"about_x_years":{"few":"близько %{count} років","many":"близько %{count} років","one":"about 1 year","other":"about %{count} years"},"almost_x_years":{"few":"майже %{count} років","many":"майже %{count} років","one":"almost 1 year","other":"almost %{count} years"},"half_a_minute":"half a minute","less_than_x_minutes":{"few":"менше %{count} хвилин","many":"менше %{count} хвилин","one":"less than a minute","other":"less than %{count} minutes"},"less_than_x_seconds":{"few":"менше %{count} секунд","many":"менше %{count} секунд","one":"less than 1 second","other":"less than %{count} seconds"},"over_x_years":{"few":"більше %{count} років","many":"більше %{count} років","one":"over 1 year","other":"over %{count} years"},"x_days":{"few":"%{count} дні","many":"%{count} днів","one":"1 day","other":"%{count} days"},"x_minutes":{"few":"%{count} хвилини","many":"%{count} хвилин","one":"1 minute","other":"%{count} minutes"},"x_months":{"few":"%{count} місяці","many":"%{count} місяців","one":"1 month","other":"%{count} months"},"x_seconds":{"few":"%{count} секунди","many":"%{count} секунд","one":"1 second","other":"%{count} seconds"},"x_years":{"few":"%{count} років","many":"%{count} років","one":"1 year","other":"%{count} years"}},"prompts":{"day":"Day","hour":"Hour","minute":"Minute","month":"Month","second":"Seconds","year":"Year"}},"devise":{"confirmations":{"confirmed":"Your email address has been successfully confirmed.","send_instructions":"You will receive an email with instructions for how to confirm your email address in a few minutes.","send_paranoid_instructions":"If your email address exists in our database, you will receive an email with instructions for how to confirm your email address in a few minutes."},"failure":{"already_authenticated":"You are already signed in.","inactive":"Your account is not activated yet.","invalid":"Invalid %{authentication_keys} or password.","last_attempt":"You have one more attempt before your account is locked.","locked":"Your account is locked.","not_found_in_database":"Invalid %{authentication_keys} or password.","timeout":"Your session expired. Please sign in again to continue.","unauthenticated":"You need to sign in or sign up before continuing.","unconfirmed":"You have to confirm your email address before continuing."},"mailer":{"confirmation_instructions":{"subject":"Confirmation instructions"},"email_changed":{"subject":"Email Changed"},"password_change":{"subject":"Password Changed"},"reset_password_instructions":{"subject":"Reset password instructions"},"unlock_instructions":{"subject":"Unlock instructions"}},"omniauth_callbacks":{"failure":"Could not authenticate you from %{kind} because \"%{reason}\".","success":"Successfully authenticated from %{kind} account."},"passwords":{"no_token":"You can't access this page without coming from a password reset email. If you do come from a password reset email, please make sure you used the full URL provided.","send_instructions":"You will receive an email with instructions on how to reset your password in a few minutes.","send_paranoid_instructions":"If your email address exists in our database, you will receive a password recovery link at your email address in a few minutes.","updated":"Your password has been changed successfully. You are now signed in.","updated_not_active":"Your password has been changed successfully."},"registrations":{"destroyed":"Bye! Your account has been successfully cancelled. We hope to see you again soon.","signed_up":"Welcome! You have signed up successfully.","signed_up_but_inactive":"You have signed up successfully. However, we could not sign you in because your account is not yet activated.","signed_up_but_locked":"You have signed up successfully. However, we could not sign you in because your account is locked.","signed_up_but_unconfirmed":"A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.","update_needs_confirmation":"You updated your account successfully, but we need to verify your new email address. Please check your email and follow the confirm link to confirm your new email address.","updated":"Your account has been updated successfully."},"sessions":{"already_signed_out":"Signed out successfully.","signed_in":"Signed in successfully.","signed_out":"Signed out successfully."},"unlocks":{"send_instructions":"You will receive an email with instructions for how to unlock your account in a few minutes.","send_paranoid_instructions":"If your account exists, you will receive an email with instructions for how to unlock it in a few minutes.","unlocked":"Your account has been unlocked successfully. Please sign in to continue."}},"didnt_receive_unlock_instructions":"Didn't receive unlock instructions?","doorkeeper":{"applications":{"buttons":{"authorize":"Authorize","cancel":"Cancel","destroy":"Destroy","edit":"Edit","submit":"Submit"},"confirmations":{"destroy":"Are you sure?"},"edit":{"title":"Edit application"},"form":{"error":"Whoops! Check your form for possible errors"},"help":{"confidential":"Application will be used where the client secret can be kept confidential. Native mobile apps and Single Page Apps are considered non-confidential.","native_redirect_uri":"Use %{native_redirect_uri} if you want to add localhost URIs for development purposes","redirect_uri":"Use one line per URI","scopes":"Separate scopes with spaces. Leave blank to use the default scopes."},"index":{"callback_url":"Callback URL","confidential":"Confidential?","confidentiality":{"no":"No","yes":"Yes"},"name":"Name","new":"New Application","title":"Your applications"},"new":{"title":"New Application"},"show":{"actions":"Actions","application_id":"Application Id","callback_urls":"Callback urls","confidential":"Confidential","scopes":"Scopes","secret":"Secret","title":"Application: %{name}"}},"authorizations":{"buttons":{"authorize":"Authorize","deny":"Deny"},"error":{"title":"An error has occurred"},"new":{"able_to":"This application will be able to","prompt":"Authorize %{client_name} to use your account?","title":"Authorization required"},"show":{"title":"Authorization code"}},"authorized_applications":{"buttons":{"revoke":"Revoke"},"confirmations":{"revoke":"Are you sure?"},"index":{"application":"Application","created_at":"Created At","date_format":"%Y-%m-%d %H:%M:%S","title":"Your authorized applications"}},"errors":{"messages":{"access_denied":"The resource owner or authorization server denied the request.","credential_flow_not_configured":"Resource Owner Password Credentials flow failed due to Doorkeeper.configure.resource_owner_from_credentials being unconfigured.","invalid_client":"Client authentication failed due to unknown client, no client authentication included, or unsupported authentication method.","invalid_grant":"The provided authorization grant is invalid, expired, revoked, does not match the redirection URI used in the authorization request, or was issued to another client.","invalid_redirect_uri":"The requested redirect uri is malformed or doesn't match client redirect URI.","invalid_request":"The request is missing a required parameter, includes an unsupported parameter value, or is otherwise malformed.","invalid_scope":"The requested scope is invalid, unknown, or malformed.","invalid_token":{"expired":"The access token expired","revoked":"The access token was revoked","unknown":"The access token is invalid"},"resource_owner_authenticator_not_configured":"Resource Owner find failed due to Doorkeeper.configure.resource_owner_authenticator being unconfigured.","server_error":"The authorization server encountered an unexpected condition which prevented it from fulfilling the request.","temporarily_unavailable":"The authorization server is currently unable to handle the request due to a temporary overloading or maintenance of the server.","unauthorized_client":"The client is not authorized to perform this request using this method.","unsupported_grant_type":"The authorization grant type is not supported by the authorization server.","unsupported_response_type":"The authorization server does not support this response type."}},"flash":{"applications":{"create":{"notice":"Application created."},"destroy":{"notice":"Application deleted."},"update":{"notice":"Application updated."}},"authorized_applications":{"destroy":{"notice":"Application revoked."}}},"layouts":{"admin":{"nav":{"applications":"Applications","home":"Home","oauth2_provider":"OAuth2 Provider"}},"application":{"title":"OAuth authorization required"}}},"english":"English","errors":{"blank":"can't be blank","connection_refused":"Oops! Failed to connect to the Web Console middleware.\nPlease make sure a rails development server is running.\n","form":{"email_format":"Must be an email format."},"format":"%{attribute} %{message}","messages":{"accepted":"must be accepted","already_confirmed":"was already confirmed, please try signing in","blank":"can't be blank","carrierwave_download_error":"could not be downloaded","carrierwave_integrity_error":"is not of an allowed file type","carrierwave_processing_error":"failed to be processed","confirmation":"doesn't match %{attribute}","confirmation_period_expired":"needs to be confirmed within %{period}, please request a new one","content_type_blacklist_error":"You are not allowed to upload %{content_type} files","content_type_whitelist_error":"You are not allowed to upload %{content_type} files","empty":"can't be empty","equal_to":"must be equal to %{count}","even":"must be even","exclusion":"is reserved","expired":"has expired, please request a new one","extension_blacklist_error":"You are not allowed to upload %{extension} files, prohibited types: %{prohibited_types}","extension_whitelist_error":"You are not allowed to upload %{extension} files, allowed types: %{allowed_types}","greater_than":"must be greater than %{count}","greater_than_or_equal_to":"must be greater than or equal to %{count}","inclusion":"is not included in the list","invalid":"is invalid","less_than":"must be less than %{count}","less_than_or_equal_to":"must be less than or equal to %{count}","max_size_error":"File size should be less than %{max_size}","min_size_error":"File size should be greater than %{min_size}","mini_magick_processing_error":"Failed to manipulate with MiniMagick, maybe it is not an image? Original Error: %{e}","model_invalid":"Validation failed: %{errors}","not_a_number":"is not a number","not_an_integer":"must be an integer","not_found":"not found","not_locked":"was not locked","not_saved":{"one":"1 error prohibited this %{resource} from being saved:","other":"%{count} errors prohibited this %{resource} from being saved:"},"odd":"must be odd","other_than":"must be other than %{count}","present":"must be blank","required":"must exist","rmagick_processing_error":"Failed to manipulate with rmagick, maybe it is not an image?","taken":"has already been taken","too_long":{"few":"занадто довгий (максимум %{count} знаки)","many":"занадто довгий (максимум %{count} знаків)","one":"is too long (maximum is 1 character)","other":"is too long (maximum is %{count} characters)"},"too_short":{"few":"занадто короткий (мінімум %{count} знаки)","many":"занадто короткий (мінімум %{count} знаків)","one":"is too short (minimum is 1 character)","other":"is too short (minimum is %{count} characters)"},"wrong_length":{"few":"неправильна довжина (має бути %{count} знаки)","many":"неправильна довжина (має бути %{count} знаків)","one":"is the wrong length (should be 1 character)","other":"is the wrong length (should be %{count} characters)"}},"min_length":"%{number} symbols min.","template":{"body":"There were problems with the following fields:","header":{"few":"%{model} не збережено через %{count} помилки","many":"%{model} не збережено через %{count} помилок","one":"1 error prohibited this %{model} from being saved","other":"%{count} errors prohibited this %{model} from being saved"}},"unacceptable_request":"A supported version is expected in the Accept header.\n","unavailable_session":"Session %{id} is no longer available in memory.\n\nIf you happen to run on a multi-process server (like Unicorn or Puma) the process\nthis request hit doesn't store %{id} in memory. Consider turning the number of\nprocesses/workers to one (1) or using a different server in development.\n"},"facebook-group":"People's Museum of Izyumshchyna","flash":{"actions":{"create":{"notice":"%{resource_name} was successfully created."},"destroy":{"alert":"%{resource_name} could not be destroyed.","notice":"%{resource_name} was successfully destroyed."},"update":{"notice":"%{resource_name} was successfully updated."}}},"forgot_you_password":"Forgot you password?","helpers":{"select":{"prompt":"Please select"},"submit":{"create":"Create %{model}","submit":"Save %{model}","update":"Update %{model}"}},"hi":"Hello","i18n":{"plural":{"keys":["one","other"],"rule":{}},"transliterate":{"rule":{}}},"i18n_tasks":{"add_missing":{"added":{"one":"Added %{count} key","other":"Added %{count} keys"}},"cmd":{"args":{"default_text":"Default: %{value}","desc":{"all_locales":"Do not expect key patterns to start with a locale, instead apply them to all locales implicitly.","confirm":"Confirm automatically","data_format":"Data format: %{valid_text}.","keep_order":"Keep the order of the keys","key_pattern":"Filter by key pattern (e.g. 'common.*')","key_pattern_to_rename":"Full key (pattern) to rename. Required","locale":"i18n_tasks.common.locale","locale_to_translate_from":"Locale to translate from","locales_filter":"Locale(s) to process. Special: base","missing_types":"Filter by types: %{valid}","new_key_name":"New name, interpolates original name as %{key}. Required","nostdin":"Do not read from stdin","out_format":"Output format: %{valid_text}","pattern_router":"Use pattern router: keys moved per config data.write","strict":"Avoid inferring dynamic key usages such as t(\"cats.#{cat}.name\"). Takes precedence over the config setting if set.","translation_backend":"Translation backend (google or deepl)","value":"Value. Interpolates: %{value}, %{human_key}, %{key}, %{default}, %{value_or_human_key}, %{value_or_default_or_human_key}"}},"desc":{"add_missing":"add missing keys to locale data","check_normalized":"verify that all translation data is normalized","config":"display i18n-tasks configuration","data":"show locale data","data_merge":"merge locale data with trees","data_remove":"remove keys present in tree from data","data_write":"replace locale data with tree","eq_base":"show translations equal to base value","find":"show where keys are used in the code","gem_path":"show path to the gem","health":"is everything OK?","irb":"start REPL session within i18n-tasks context","missing":"show missing translations","mv":"rename/merge the keys in locale data that match the given pattern","normalize":"normalize translation data: sort and move to the right files","remove_unused":"remove unused keys","rm":"remove the keys in locale data that match the given pattern","translate_missing":"translate missing keys with Google Translate or DeepL Pro","tree_convert":"convert tree between formats","tree_filter":"filter tree by key pattern","tree_merge":"merge trees","tree_mv_key":"rename/merge/remove the keys matching the given pattern","tree_set_value":"set values of keys, optionally match a pattern","tree_subtract":"tree A minus the keys in tree B","tree_translate":"Google Translate a tree to root locales","unused":"show unused translations"},"encourage":["Good job!","Well done!","Perfect!"],"enum_list_opt":{"invalid":"%{invalid} is not in: %{valid}."},"enum_opt":{"invalid":"%{invalid} is not one of: %{valid}."},"errors":{"invalid_format":"invalid format: %{invalid}. valid: %{valid}.","invalid_locale":"invalid locale: %{invalid}","invalid_missing_type":{"one":"invalid type: %{invalid}. valid: %{valid}.","other":"unknown types: %{invalid}. valid: %{valid}."},"pass_forest":"pass locale forest"}},"common":{"continue_q":"Continue?","key":"Key","locale":"Locale","n_more":"%{count} more","value":"Value"},"data_stats":{"text":"has %{key_count} keys across %{locale_count} locales. On average, values are %{value_chars_avg} characters long, keys have %{key_segments_avg} segments, a locale has %{per_locale_avg} keys.","text_single_locale":"has %{key_count} keys in total. On average, values are %{value_chars_avg} characters long, keys have %{key_segments_avg} segments.","title":"Forest (%{locales})"},"deepl_translate":{"errors":{"no_api_key":"Setup DeepL Pro API key via DEEPL_AUTH_KEY environment variable or translation.deepl_api_key in config/i18n-tasks.yml. Get the key at https://www.deepl.com/pro.","no_results":"DeepL returned no results."}},"google_translate":{"errors":{"no_api_key":"Set Google API key via GOOGLE_TRANSLATE_API_KEY environment variable or translation.google_translate_api_key in config/i18n-tasks.yml. Get the key at https://code.google.com/apis/console.","no_results":"Google Translate returned no results. Make sure billing information is set at https://code.google.com/apis/console."}},"health":{"no_keys_detected":"No keys detected. Check data.read in config/i18n-tasks.yml."},"missing":{"details_title":"Value in other locales or source","none":"No translations are missing."},"remove_unused":{"confirm":{"one":"%{count} translation will be removed from %{locales}.","other":"%{count} translation will be removed from %{locales}."},"noop":"No unused keys to remove","removed":"Removed %{count} keys"},"translate_missing":{"translated":"Translated %{count} keys"},"unused":{"none":"Every translation is in use."},"usages":{"none":"No key usages found."}},"if_you_didnt_request_this_please_ignore_this_email":"If you didn't request this, please ignore this email.","language":"Language","main":"Main","maps_and_plans":"Maps and plans","new_password":"New password","number":{"currency":{"format":{"delimiter":",","format":"%u%n","precision":2,"separator":".","significant":false,"strip_insignificant_zeros":false,"unit":"$"}},"format":{"delimiter":",","precision":3,"separator":".","significant":false,"strip_insignificant_zeros":false},"human":{"decimal_units":{"format":"%n %u","units":{"billion":"Billion","million":"Million","quadrillion":"Quadrillion","thousand":"Thousand","trillion":"Trillion","unit":""}},"format":{"delimiter":"","precision":3,"significant":true,"strip_insignificant_zeros":true},"storage_units":{"format":"%n %u","units":{"byte":{"few":"байти","many":"байтів","one":"Byte","other":"Bytes"},"eb":"EB","gb":"GB","kb":"KB","mb":"MB","pb":"PB","tb":"TB"}}},"percentage":{"format":{"delimiter":"","format":"%n%"}},"precision":{"format":{"delimiter":""}}},"registration":{"confirmation":{"question":"Didn't receive confirmation instructions?"},"current_password":"Current password","delete_account":"Delete account","email":"Email","first_name":"Last name","forgot_password_question":"Forgot your password?","last_changes":"Last changes","last_name":"First name","leave_blank_password":"(leave the field blank if you do not want to change the password)","need_password_to_confirm":"(we need your current password to confirm the changes)","nickname":"Nickname","password":"Password","password_confirmation":"Password confirmation","password_min":"symbols min","profile":"Profile","registered":"Registered","remember_me":"Remember me","sign_in":"Sign in","sign_out":"Sign out","sign_up":"Sign up","title":"Registration","wait_email_confirmation":"Currently waiting confirmation for:"},"resend_change_password_instructions":"Resend change password instructions","resend_confirmation_instructions":"Resend confirmation instructions","resend_unlock_instructions":"Resend unlock instructions","saving":"Saving...","search":"Search","search_results":"Search results for","send":"Send","sign_in_with":"Sign in with","site_name":"Izjum fortress","someone_has_requested_a_link_to_change_your_password_you_can_do_this_through_the_link_below":"Someone has requested a link to change your password. You can do this through the link below.","support":{"array":{"last_word_connector":", and ","two_words_connector":" and ","words_connector":", "}},"time":{"am":"am","formats":{"default":"%a, %d %b %Y %H:%M:%S %z","long":"%B %d, %Y %H:%M","short":"%d %b %H:%M"},"pm":"pm"},"titles":{"attachments":{"add":"Add image","delete":"Delete image"},"author":"Author","comments":{"add":"Add comment","all":"Comments","delete":"Delete comment","edit":"Edit comment","text":"Comment:"},"edit_profile":"Edit profile","posts":{"add":"Add post","all":"Posts","body":"Body","create":"Create post","delete":"Remove post","edit":"Edit","title":"Title"},"users":{"all":"Users"}},"ukrainian":"Українська","unlock_my_account":"Unlock my account","we_are_contacting_you_to_notify_you_that_your_password_has_been_changed":"We're contacting you to notify you that your password has been changed.","you_can_confirm_your_account_email_through_the_link_below":"You can confirm your account email through the link below:","your_account_has_been_locked_due_to_an_excessive_number_of_unsuccessful_sign_in_attempts":"Your account has been locked due to an excessive number of unsuccessful sign in attempts.","your_password_wont_change_until_you_access_the_link_above_and_create_a_new_one":"Your password won't change until you access the link above and create a new one."});
