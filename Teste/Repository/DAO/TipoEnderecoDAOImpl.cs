using Domain;
using Repository.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace Repository.DAO
{
    public class TipoEnderecoDAOImpl : BaseDAOImpl<TipoEndereco>
    {
        public TipoEnderecoDAOImpl(DatabaseOptions databaseOptions) : base(databaseOptions) { }

        public override bool Delete(TipoEndereco entity)
        {
            throw new NotImplementedException();
        }

        public override TipoEndereco GetByID(int id)
        {
            throw new NotImplementedException();
        }

        public override List<TipoEndereco> ListAll()
        {
            var list = new List<TipoEndereco>();

            using (DataTable dt = this.GetDatatable("spListaTipoEndereco"))
            {
                foreach (DataRow row in dt.Rows)
                {
                    list.Add(ParseToObject(row));
                }
            }

            return list;
        }

        public override TipoEndereco ParseToObject(DataRow row)
        {
            return new TipoEndereco()
            {
                Id = row.GetValue("Id", default(int)),
                Descricao = row.GetValue("Descricao", string.Empty),
                Ativo = row.GetValue("Ativo", default(bool))
            };
        }

        public override bool Save(TipoEndereco entity)
        {
            throw new NotImplementedException();
        }

        public override bool Update(TipoEndereco entity)
        {
            throw new NotImplementedException();
        }
    }
}
