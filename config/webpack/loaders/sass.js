module.exports = {
  test: /\.(scss|sass|css)$/i,
  use: [{
    loader: 'resolve-url-loader',
  }],
};
