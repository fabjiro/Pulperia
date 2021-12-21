const vm = new Vue({
  el: "#vm",
  delimiters: ["[[", "]]"],
  data: {
    data: { user: null, pass: null },
    message: {
      state: false,
      smg: null,
    },
  },
  methods: {
    send() {
      axios
        .post("/api/accessadmin", {
          username: this.data.user,
          password: this.data.pass,
        })
        .then((s) => {
          if (s.data["status"] == 200) {
            window.location = "/manager";
          } else {
            this.message.smg = s.data["smg"];
            this.message.state = true;
            setTimeout(() => (this.message.state = false), 2000);
          }
        });
    },
  },
});
