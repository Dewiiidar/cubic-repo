using Core.Entities;
using Microsoft.EntityFrameworkCore;

namespace InfraStructure.Data
{
    public class CubicContext : DbContext
    {
        public CubicContext(DbContextOptions options) : base(options)
        {
        }
        public DbSet<User> users { get; set; }
        public DbSet<Privilege> privileges { get; set; }
        public DbSet<Role> roles { get; set; }
        public DbSet<RolePrivilege> rolePrivileges { get; set; }
        public DbSet<Item> items { get; set; }
        public DbSet<Price> prices { get; set; }



        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<RolePrivilege>()
                 .HasKey(utp => new { utp.RoleId, utp.PrivilegeId });

            modelBuilder.Entity<RolePrivilege>()
                .HasOne(utp => utp.UserRole)
                .WithMany()
                .HasForeignKey(utp => utp.RoleId);

            modelBuilder.Entity<RolePrivilege>()
                .HasOne(utp => utp.Privilege)
                .WithMany()
                .HasForeignKey(utp => utp.PrivilegeId);
        }
    }
}
