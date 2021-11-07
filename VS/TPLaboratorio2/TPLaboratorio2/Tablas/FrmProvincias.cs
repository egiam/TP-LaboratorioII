using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TPLaboratorio2.Dao;

namespace TPLaboratorio2.Tablas
{
    public partial class FrmProvincias : Form
    {
        public FrmProvincias()
        {
            InitializeComponent();
        }

        private void FrmProvincias_Load(object sender, EventArgs e)
        {
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
    }
}
