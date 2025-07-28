using Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.DTOs
{
    public class PriceDTO
    {
        public int Id { get; set; }
        public int ItemId { get; set; } // Item FK.
        public Item? Item { get; set; }
        public string? ItemName { get; set; }
        public float Value { get; set; }
        public DateTime ActiveFrom { get; set; }
        public DateTime ActiveTo { get; set; }
    }
}
