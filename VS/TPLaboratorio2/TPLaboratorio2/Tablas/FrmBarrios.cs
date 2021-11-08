using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace TPLaboratorio2.Tablas
{
    public partial class FrmBarrios : Form
    {
        public FrmBarrios()
        {
            InitializeComponent();
        }

        private void FrmBarrios_Load(object sender, EventArgs e)
        {
            string select = "select cod_barrio, barrio, localidad from localidades l join barrios b on b.cod_localidad = l.cod_localidad";
            grdBarrios.DataSource = consultarTabla(select);
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
    }
}
