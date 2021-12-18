const vm = new Vue({
  el: "#vm",
  delimiters: ["[[", "]]"],
  data: {
    data: {
      id: null,
      urlimage: null,
      title: null,
      image: null,
    },
    state: { lodCont: true, panel: false, edit: false, fondo: false },
    listSpecific: {},
    Pgeneral: {
      title: null,
    },
  },
  methods: {
    getproduct() {
      this.state.lodCont = true;
      axios
        .post("/api/getspecific", {
          id: Cookies.get("id"),
        })
        .then((res) => {
          this.listSpecific = res.data;
          this.state.lodCont = false;
        });
    },
    newFile(e) {
      this.data.imagen = e.target.files[0];
      this.data.urlimage = URL.createObjectURL(e.target.files[0]);
    },
    editbtnconfirm() {
      if (confirm("Desea cambiar ->" + this.data.title)) {
        this.state.fondo = true;
        let form = new FormData();
        form.append("image", this.data.imagen);
        form.append("title", this.data.title);
        form.append("id", this.data.id);
        axios.post("/api/editspecific", form).then((res) => {
          this.state.fondo = false;
          if (res.data["status"] == 200) {
            this.toglepanel();
            this.getproduct();
          } else {
            alert(res.data["smg"]);
          }
        });
      }
    },
    btnclose() {
      this.state.edit = false;
      this.toglepanel();
    },
    btnsaved() {
      this.state.fondo = true;

      let form = new FormData();
      form.append("image", this.data.imagen);
      form.append("title", this.data.title);
      form.append("idgeneral", Cookies.get("id"));

      axios.post("/api/addspecific", form).then((res) => {
        this.state.fondo = false;

        if (res.data["status"] == 200) {
          this.toglepanel();
          this.getproduct();
        } else {
          alert(res.data["smg"]);
        }
      });
    },
    btnadd() {
      this.data.title = null;
      this.data.urlimage = null;
      this.toglepanel();
    },
    btnEdit(item) {
      this.state.edit = true;
      this.data.title = item["title"];
      this.data.id = item["id"];
      this.data.urlimage = item["urlimage"];
      this.toglepanel();
    },
    btndelete(item) {
      this.state.fondo = true;
      if (confirm("Desea eliminar ->" + item["title"])) {
        axios
          .post("/api/delspecific", {
            id: item["id"],
          })
          .then((res) => {
            this.state.fondo = false;
            if (res.data["status"] == 200) {
              this.getproduct();
            }
          });
      }
    },
    toglepanel() {
      this.state.panel = !this.state.panel;
    },
  },
  created() {
    this.Pgeneral.title = Cookies.get("title");
    this.getproduct();
  },
});
