using Domain;
using Repository.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace Repository.DAO
{
    public class TipoTelefoneDAOImpl : BaseDAOImpl<TipoTelefone>
    {
        public TipoTelefoneDAOImpl(DatabaseOptions databaseOptions) : base(databaseOptions) { }

        public override bool Delete(TipoTelefone entity)
        {
            throw new NotImplementedException();
        }

        public override TipoTelefone GetByID(int id)
        {
            throw new NotImplementedException();
        }

        public override List<TipoTelefone> ListAll()
        {
            var list = new List<TipoTelefone>();

            using (DataTable dt = this.GetDatatable("spListaTipoTelefone"))
            {
                foreach (DataRow row in dt.Rows)
                {
                    list.Add(ParseToObject(row));
                }
            }

            return list;
        }

        public override TipoTelefone ParseToObject(DataRow row)
        {
            return new TipoTelefone()
            {
                Id = row.GetValue("Id", default(int)),
                Descricao = row.GetValue("Descricao", string.Empty),
                Ativo = row.GetValue("Ativo", default(bool))
            };
        }

        public override bool Save(TipoTelefone entity)
        {
            throw new NotImplementedException();
        }

        public override bool Update(TipoTelefone entity)
        {
            throw new NotImplementedException();
        }
    }
}
