/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './src/**/*.tsx',
  ],
  theme: {
    extend: {
      colors: {
        primary: '#F6F4EB',
        secondary: {
          100: '#F9F2ED',
          200: '#3AB0FF',
          300: '#FFB562',
          400: '#F87474'
        },
        alternative:{
          100: '#13334C',
          200: '#005792',
          300: '#F6F6E9',
          400: '#FD5F00',
        }
      }
    },
  },
  plugins: [],
}
