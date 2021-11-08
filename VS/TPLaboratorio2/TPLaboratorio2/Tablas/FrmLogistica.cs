using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace TPLaboratorio2.Tablas
{
    public partial class FrmLogistica : Form
    {
        public FrmLogistica()
        {
            InitializeComponent();
        }

        private void FrmLogistica_Load(object sender, EventArgs e)
        {
            string select = "select id_empresas_log, nombre, barrio, calle+', '+str(nro_calle) from empresas_logistica e join barrios b on e.cod_barrio = b.cod_barrio";
            grdES.DataSource = consultarTabla(select);
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
