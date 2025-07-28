using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class RolePrivilege
    {
        public int RoleId { get; set; }   // FK to UserRole.Id
        public Role UserRole { get; set; }  // PK part 1
        public int PrivilegeId { get; set; }    // PK part 2
        public Privilege Privilege { get; set; }
    }
}
