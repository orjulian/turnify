<template>
  <div class="home">
    <div>
      <h3>Signin</h3>
      Email
      <input v-model="email">
      Password
      <input v-model="password">
      <button @click="signIn()">Sign In</button>
    </div>
    <div>
      <h3>Signup</h3>
      Email
      <input v-model="createEmail">
      Password
      <input v-model="createPassword">
      Role ('patient' or 'admin' or 'profesional')
      <input v-model="createRole">
      <button @click="createUser()">Create</button>
    </div>
    <img alt="Vue logo" src="../assets/logo.png">
    <HelloWorld msg="Welcome to Your Vue.js App"/>
  </div>
</template>

<script>
// @ is an alias to /src
import HelloWorld from '@/components/HelloWorld.vue'
import { SIGNIN, CREATE_USER } from '@/graphql/mutations'

export default {
  name: 'Home',
  components: {
    HelloWorld
  },
  data () {
    return {
      email: 'alan@alan.com',
      password: '123123',
      createEmail: '',
      createPassword: '',
      createRole: 'patient'
    }
  },
  methods: {
    createUser () {
      this.$apollo.mutate({
        mutation: CREATE_USER,
        variables: {
          email: this.createEmail,
          password: this.createPassword,
          passwordConfirmation: this.createPassword,
          role: this.createRole
        }
      }).then( res => {
        console.log(`YAY! created user ${res.data.createUser.email}`)
      }).catch( err => {
        console.log(`Ops! Problem creating user ${this.createEmail}`)
      })
    },
    signIn () {
      this.$apollo.mutate({
        mutation: SIGNIN,
        variables: {
          email: this.email,
          password: this.password
        }
      }).then( res => {
        console.log(res.data.signIn.token)
      }).catch( err => {
        console.log(err)
      })
    }
  }
}
</script>
