using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Windows.Forms;

namespace TPLaboratorio2.Tablas
{
    public partial class FrmProvincias : Form
    {
        ConeccionEntreForms conex;
        public FrmProvincias()
        {
            InitializeComponent();
            conex = new ConeccionEntreForms();
        }

        private void FrmProvincias_Load(object sender, EventArgs e)
        {
            BackColor = Color.FromArgb(45, 66, 91);
            conex.AlternarColorGRD(grdProvincias);
            string select = "select * from provincias";
            grdProvincias.DataSource = consultarTabla(select);
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

        private void grdProvincias_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
