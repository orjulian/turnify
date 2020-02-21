import gql from 'graphql-tag'

const SIGNIN = gql`mutation signIn($email: String!, $password: String!) {
  signIn(
    email: $email,
    password: $password
  ) {
    token
  }
}`

const CREATE_USER = gql`mutation createUser($email: String!, $password: String!, $passwordConfirmation: String!, $role: String!) {
  createUser(
    email: $email,
    password: $password,
    passwordConfirmation: $passwordConfirmation,
    role: $role
  ) {
    id
    email
  }
}`

export { SIGNIN, CREATE_USER }
