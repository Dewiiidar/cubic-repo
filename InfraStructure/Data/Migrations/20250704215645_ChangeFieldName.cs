using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace InfraStructure.Data.Migrations
{
    /// <inheritdoc />
    public partial class ChangeFieldName : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_rolePrivileges_roles_UserRoleId",
                table: "rolePrivileges");

            migrationBuilder.RenameColumn(
                name: "UserRoleId",
                table: "rolePrivileges",
                newName: "RoleId");

            migrationBuilder.AddForeignKey(
                name: "FK_rolePrivileges_roles_RoleId",
                table: "rolePrivileges",
                column: "RoleId",
                principalTable: "roles",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_rolePrivileges_roles_RoleId",
                table: "rolePrivileges");

            migrationBuilder.RenameColumn(
                name: "RoleId",
                table: "rolePrivileges",
                newName: "UserRoleId");

            migrationBuilder.AddForeignKey(
                name: "FK_rolePrivileges_roles_UserRoleId",
                table: "rolePrivileges",
                column: "UserRoleId",
                principalTable: "roles",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
