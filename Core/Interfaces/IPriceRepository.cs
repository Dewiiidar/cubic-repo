using Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Interfaces
{
    public interface IPriceRepository
    {
        Task<int> GetPricesCountAsync();
        Task<IEnumerable<Price>> GetAllPricesAsync(int limit, int offset);
        Task<Price> GetPriceByIdAsync(int id);
        public Task<int> AddPriceAsync(Price price);
        Task<bool> DeletePrice(int id);
    }
}
