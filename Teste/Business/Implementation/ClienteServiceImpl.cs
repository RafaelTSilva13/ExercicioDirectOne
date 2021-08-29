using Domain;
using Repository;

namespace Business.Implementation
{
    public class ClienteServiceImpl : IBaseService<Cliente>
    {
        private readonly IBaseRepository<Cliente> baseRepository;

        public ClienteServiceImpl(IBaseRepository<Cliente> baseRepository)
        {
            this.baseRepository = baseRepository;
        }

        public bool Delete(Cliente entity)
        {
            return this.baseRepository.Delete(entity);
        }

        public Cliente GetByID(int id)
        {
            return this.baseRepository.GetByID(id);
        }

        public System.Collections.Generic.List<Cliente> ListAll()
        {
            return this.baseRepository.ListAll();
        }

        public bool Save(Cliente entity)
        {
            entity.Ativo = true;
            return this.baseRepository.Save(entity);
        }

        public bool Update(Cliente entity)
        {
            entity.Ativo = true;
            return this.baseRepository.Update(entity);
        }
    }
}