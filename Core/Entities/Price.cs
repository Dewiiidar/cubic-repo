using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class Price : BaseEntity
    {
        public int ItemId { get; set; } // Item FK.
        public Item Item { get; set; }

        public float Value { get; set; }
        public DateTime ActiveFrom { get; set; }
        public DateTime ActiveTo { get; set; }
    }
}
