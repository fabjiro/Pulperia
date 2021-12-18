const vm = new Vue({
  el: "#vm",
  delimiters: ["[[", "]]"],
  data: {
    data: {
      title: null,
      id: null,
    },
    state: {
      lodCont: true,
      panel: false,
      edit: false,
      fondo: false,
    },
    listGeneral: {
      title: null,
    },
  },
  methods: {
    btnchild(item) {
      Cookies.set("id", item["id"]);
      Cookies.set("title", item["title"]);
      window.location = "/product";
    },
    btnaddConfirm() {
      this.state.fondo = true;
      axios
        .post("/api/addgeneral", {
          title: this.data.title,
        })
        .then((res) => {
          this.state.fondo = false;
          if (res.data["status"] == 200) {
            this.toglepanel();
            this.getGeneral();
          }
        });
    },
    getGeneral() {
      this.state.lodCont = true;
      axios.get("/api/getgeneral").then((res) => {
        if (res.status == 200) {
          this.listGeneral = res.data;
          this.state.lodCont = false;
        }
      });
    },
    btndelete(item) {
      if (confirm("Desea eliminar ->" + item["title"])) {
        this.state.fondo = true;
        axios
          .post("/api/deletegeneral", {
            id: item["id"],
          })
          .then((res) => {
            this.state.fondo = false;
            if (res.data["status"] == 200) {
              this.getGeneral();
            }
          });
      }
    },
    btnEdit(item) {
      this.state.edit = true;
      this.data.title = item["title"];
      this.data.id = item["id"];
      this.toglepanel();
    },
    btnEditConfirm() {
      if (confirm("Desea editar -> " + this.data.title)) {
        this.state.fondo = true;
        axios
          .post("/api/updategeneral", {
            title: this.data.title,
            id: this.data.id,
          })
          .then((res) => {
            this.state.fondo = false;
            if (res.data["status"] == 200) {
              this.toglepanel();
              this.getGeneral();
            }
          });
      }
    },
    btnclose() {
      this.state.edit = false;
      this.toglepanel();
    },
    btnadd() {
      this.data.title = null;
      this.toglepanel();
    },
    toglepanel() {
      this.state.panel = !this.state.panel;
    },
  },
  created() {
    this.getGeneral();
  },
});
