import gql from 'graphql-tag'

const SIGNIN = gql`mutation signIn($email: String!, $password: String!) {
  signIn(
    email: $email,
    password: $password
  ) {
    token
  }
}`

export { SIGNIN }
