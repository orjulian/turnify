<template>
  <div class="home">
    <img alt="Vue logo" src="../assets/logo.png">
    <HelloWorld msg="Welcome to Your Vue.js App"/>
    <button @click="signIn()">Sign In</button>
  </div>
</template>

<script>
// @ is an alias to /src
import HelloWorld from '@/components/HelloWorld.vue'
import { SIGNIN } from '@/graphql/mutations'

export default {
  name: 'Home',
  components: {
    HelloWorld
  },
  data () {
    return {
      email: '',
      password: ''
    }
  },
  methods: {
    signIn () {
      this.$apollo.mutate({
        mutation: SIGNIN,
        variables: {
          email: this.email,
          password: this.password
        }
      }).then( res => {
        console.log(res)
      }).catch( err => {
        console.log(err)
      })
    }
  }
}
</script>
