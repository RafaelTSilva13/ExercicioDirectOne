using Domain;
using Repository.Util;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace Repository.DAO
{
    public class TipoRedeSocialDAOImpl : BaseDAOImpl<TipoRedeSocial>
    {
        public TipoRedeSocialDAOImpl(DatabaseOptions databaseOptions) : base(databaseOptions) { }

        public override bool Delete(TipoRedeSocial entity)
        {
            throw new NotImplementedException();
        }

        public override TipoRedeSocial GetByID(int id)
        {
            throw new NotImplementedException();
        }

        public override List<TipoRedeSocial> ListAll()
        {
            var list = new List<TipoRedeSocial>();

            using (DataTable dt = this.GetDatatable("spListaTipoRedeSocial"))
            {
                foreach (DataRow row in dt.Rows)
                {
                    list.Add(ParseToObject(row));
                }
            }

            return list;
        }

        public override TipoRedeSocial ParseToObject(DataRow row)
        {
            return new TipoRedeSocial()
            {
                Id = row.GetValue("Id", default(int)),
                Descricao = row.GetValue("Descricao", string.Empty),
                Ativo = row.GetValue("Ativo", default(bool))
            };
        }

        public override bool Save(TipoRedeSocial entity)
        {
            throw new NotImplementedException();
        }

        public override bool Update(TipoRedeSocial entity)
        {
            throw new NotImplementedException();
        }
    }
}
