using System.Collections.Generic;
using Business;
using Domain;
using Microsoft.AspNetCore.Mvc;

namespace Webapi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ClienteController : ControllerBase
    {
        private readonly IBaseService<Cliente> baseService;

        public ClienteController(IBaseService<Cliente> baseService)
        {
            this.baseService = baseService;
        }

        [HttpGet("{id}")]
        public Cliente Get(int id)
        {
            return this.baseService.GetByID(id);
        }

        [HttpGet]
        public IEnumerable<Cliente> GetAll()
        {
            return this.baseService.ListAll();
        }

        [HttpPost]
        public Cliente Save(Cliente cliente)
        {
            var result = this.baseService.Save(cliente);
            return cliente;
        }

        [HttpPut]
        public Cliente Update(Cliente cliente)
        {
            var result = this.baseService.Update(cliente);
            return cliente;
        }

        [HttpDelete("{id}")]
        public Cliente Delete(int id)
        {
            Cliente cliente = new Cliente() { Id = id};
            var result = this.baseService.Delete(cliente);
            return cliente;
        }
    }
}