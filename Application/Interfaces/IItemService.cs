using Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Interfaces
{
    public interface IItemService
    {
        Task<int> GetItemsCountAsync();
        Task<IEnumerable<Item>> GetAllItemsAsync(int limit, int offset);
        Task<IEnumerable<Item>> GetItemsByNameAsync(string term);
        Task<Item> GetItemByIdAsync(int id);

        public Task<int> AddItemAsync(Item item);
        Task<bool> UpdateItem(Item item);
        Task<bool> DeleteItem(int id);
    }
}
