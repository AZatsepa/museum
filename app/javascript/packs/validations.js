$(window).bind('turbolinks:load', () => {
  $('#new_user').validate({
    rules: {
      'user[email]': {
        required: true,
        email: true,
      },
      'user[password]': {
        required: true,
        minlength: 6,
      },
    },
    messages: {
      'user[email]': {
        required: I18n.t('errors.form.email_format'),
        email: I18n.t('errors.blank'),
      },
      'user[password]': {
        required: I18n.t('errors.blank'),
        minlength: I18n.t('errors.min_length', { number: 6 }),
      },
    },
  });

  $('#create_user').validate({
    rules: {
      'user[email]': {
        required: true,
        email: true,
      },
      'user[password]': {
        required: true,
        minlength: 6,
      },
      'user[password_confirmation]': {
        required: true,
        minlength: 6,
        equalTo: 'user[password]',
      },
    },
    messages: {
      'user[email]': {
        required: I18n.t('errors.form.email_format'),
        email: I18n.t('errors.blank'),
      },
      'user[password]': {
        required: I18n.t('errors.blank'),
        minlength: I18n.t('errors.min_length', { number: 6 }),
      },
      'user[password_confirmation]': {
        required: I18n.t('errors.blank'),
        minlength: I18n.t('errors.min_length', { number: 6 }),
        equalTo: I18n.t('errors.form.password_confirmation'),
      },
    },
  });

  $('#resend_instructions').validate({
    rules: {
      'user[email]': {
        required: true,
        email: true,
      },
    },
    messages: {
      'user[email]': {
        required: I18n.t('errors.form.email_format'),
        email: I18n.t('errors.blank'),
      },
    },
  });
});
