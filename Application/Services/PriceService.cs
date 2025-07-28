using Application.Interfaces;
using Core.Entities;
using Core.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Services
{
    public class PriceService : IPriceService
    {
        private readonly IPriceRepository _priceRepository;

        public PriceService(IPriceRepository priceRepository)
        {
            _priceRepository = priceRepository;
        }

        public async Task<int> AddPriceAsync(Price price)
        {
            return await _priceRepository.AddPriceAsync(price);
        }

        public async Task<bool> DeletePrice(int id)
        {
            return await _priceRepository.DeletePrice(id);
        }

        public async Task<IEnumerable<Price>> GetAllPricesAsync(int limit, int offset)
        {
            return await _priceRepository.GetAllPricesAsync(limit, offset);
        }

        public async Task<Price> GetPriceByIdAsync(int id)
        {
            return await _priceRepository.GetPriceByIdAsync(id);
        }

        public async Task<int> GetPricesCountAsync()
        {
            return await _priceRepository.GetPricesCountAsync();
        }
    }
}
