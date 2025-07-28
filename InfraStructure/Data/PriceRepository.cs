using Core.Entities;
using Core.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InfraStructure.Data
{
    public class PriceRepository : IPriceRepository
    {
        private readonly CubicContext _context;

        public PriceRepository(CubicContext context)
        {
            _context = context;
        }

        public async Task<int> AddPriceAsync(Price price)
        {
            await _context.prices.AddAsync(price);
            await _context.SaveChangesAsync();
            return price.Id;
        }

        public async Task<bool> DeletePrice(int id)
        {
            var price = await _context.prices.FindAsync(id);
            if (price != null)
            {
                _context.prices.Remove(price);
                await _context.SaveChangesAsync();
                return true;
            }
            return false;
        }

        public async Task<IEnumerable<Price>> GetAllPricesAsync(int limit, int offset)
        {
            return await _context.prices
                    .Include(x => x.Item)
                    .OrderBy(x => x.Id)
                    .Skip(offset)
                    .Take(limit)
                    .ToListAsync();
        }

        public async Task<Price> GetPriceByIdAsync(int id)
        {
            return await _context.prices.FindAsync(id);
        }

        public async Task<int> GetPricesCountAsync()
        {
            return await _context.prices.CountAsync();
        }
    }
}
