using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Windows.Forms;

namespace TPLaboratorio2.Tablas
{
    public partial class FrmLogistica : Form
    {
        ConeccionEntreForms conex;
        public FrmLogistica()
        {
            InitializeComponent();
            conex = new ConeccionEntreForms();
        }

        private void FrmLogistica_Load(object sender, EventArgs e)
        {
            BackColor = Color.FromArgb(45, 66, 91);
            conex.AlternarColorGRD(grdLogistica);
            string select = "select id_empresas_log, nombre, barrio, calle+', '+str(nro_calle) from empresas_logistica e join barrios b on e.cod_barrio = b.cod_barrio";
            grdLogistica.DataSource = consultarTabla(select);
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
