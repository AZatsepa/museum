module.exports = {
  test: /\.vue(\.slim)?$/,
  loader: [
    // {
    //   loader: 'vue-template-compiler-loader',
    // },
    {
      loader: 'slim-lang-loader',
      options: {
        slimOptions: {
          disable_escape: true,
        },
      },
    },
  ],
};
