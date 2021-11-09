using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Windows.Forms;

namespace TPLaboratorio2.Tablas
{
    public partial class FrmLocalidades : Form
    {
        ConeccionEntreForms conex;
        public FrmLocalidades()
        {
            InitializeComponent();
            conex = new ConeccionEntreForms();
        }

        private void FrmLocalidades_Load(object sender, EventArgs e)
        {
            BackColor = Color.FromArgb(45, 66, 91);
            conex.AlternarColorGRD(grdLocalidades);
            string select = "select cod_localidad, localidad, provincia from localidades l join provincias p on l.cod_provincia = p.cod_provincia";
            grdLocalidades.DataSource = consultarTabla(select);
        }

        SqlConnection conexion = new SqlConnection(@"Data Source=localhost\SQLEXPRESS;Initial Catalog=Farmaceutica;Integrated Security=True");
        SqlCommand comando = new SqlCommand();
        DataTable tabla = new DataTable();

        private DataTable consultarTabla(string select)
        {
            conexion.Open();

            comando.Connection = conexion;
            comando.CommandType = CommandType.Text;
            comando.CommandText = select;
            DataTable tabla = new DataTable();
            tabla.Load(comando.ExecuteReader());

            conexion.Close();

            return tabla;
        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
