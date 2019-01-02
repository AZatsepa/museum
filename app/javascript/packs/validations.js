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
        equalTo: '#user_password',
      },
      'user[nickname]': {
        required() {
          return $('#user_first_name').val().length === 0 || $('#user_last_name').val().length === 0;
        },
      },
      'user[first_name]': {
        required() {
          return $('#user_last_name').val().length === 0 && $('#user_nickname').val().length === 0;
        },
      },
      'user[last_name]': {
        required() {
          return $('#user_first_name').val().length === 0 && $('#user_nickname').val().length === 0;
        },
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
      'user[nickname]': I18n.t('errors.form.nickname'),
      'user[first_name]': I18n.t('errors.form.first_name'),
      'user[last_name]': I18n.t('errors.form.last_name'),
    },
  });

  $('#forgotten_password').validate({
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

  $('#new_confirmation').validate({
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
  $('#edit_user').validate({
    rules: {
      'user[email]': {
        required: true,
        email: true,
      },
      'user[nickname]': {
        required() {
          return $('#user_first_name').val().length === 0 || $('#user_last_name').val().length === 0;
        },
      },
      'user[first_name]': {
        required() {
          return $('#user_last_name').val().length === 0 && $('#user_nickname').val().length === 0;
        },
      },
      'user[last_name]': {
        required() {
          return $('#user_first_name').val().length === 0 && $('#user_nickname').val().length === 0;
        },
      },
      'user[password]': {
        minlength: 6,
      },
      'user[password_confirmation]': {
        minlength: 6,
        equalTo: {
          param: '#user_password',
          depends() {
            return $('#user_password').val().length > 0;
          },
        },
      },
      'user[current_password]': {
        required: true,
      },
    },
    messages: {
      'user[email]': {
        required: I18n.t('errors.form.email_format'),
        email: I18n.t('errors.blank'),
      },
      'user[nickname]': I18n.t('errors.form.nickname'),
      'user[first_name]': I18n.t('errors.form.first_name'),
      'user[last_name]': I18n.t('errors.form.last_name'),
      'user[current_password]': I18n.t('errors.form.current_password'),
      'user[password]': {
        minlength: I18n.t('errors.min_length', { number: 6 }),
      },
      'user[password_confirmation]': {
        required: I18n.t('errors.blank'),
        minlength: I18n.t('errors.min_length', { number: 6 }),
        equalTo: I18n.t('errors.form.password_confirmation'),
      },
    },
  });
});
