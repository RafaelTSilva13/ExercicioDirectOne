using Domain;
using Repository;
using System.Collections.Generic;

namespace Business.Implementation
{
    public class BaseServiceImpl<T> : IBaseService<T> where T : ModelBase
    {
        private readonly IBaseRepository<T> baseRepository;

        public BaseServiceImpl(IBaseRepository<T> baseRepository)
        {
            this.baseRepository = baseRepository;
        }

        public bool Delete(T entity)
        {
            return this.baseRepository.Delete(entity);
        }

        public T GetByID(int id)
        {
            return this.baseRepository.GetByID(id);
        }

        public List<T> ListAll()
        {
            return this.baseRepository.ListAll();
        }

        public bool Save(T entity)
        {
            return this.baseRepository.Save(entity);
        }

        public bool Update(T entity)
        {
            return this.baseRepository.Update(entity);
        }
    }
}
