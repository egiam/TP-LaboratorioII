﻿namespace TPLaboratorio2.Dao
{
    public class Parametro
    {
        public Parametro()
        {

        }

        public Parametro(string nombre, object valor)
        {
            Nombre = nombre;
            Valor = valor;
        }

        public string Nombre { get; set; }
        public object Valor { get; set; }
    }
}
