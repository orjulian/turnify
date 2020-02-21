module.exports = {
  devServer: {
    progress: false,
    proxy: 'http://localhost:4000/api/graphql'
  }
}
