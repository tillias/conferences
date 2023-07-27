import "@typespec/http";
import "./model.tsp";

using TypeSpec.Http;

@service({
  title: "Pet Store Service",
  version: "2021-03-25",
})
@server("https://example.com", "Single server endpoint")
@doc("This is a sample Petstore server.")
namespace Pets;

@route("/pets")
interface PetStore {
  @get list(): Pet[] | Error;
  @get read(@path id: int32): Pet | Error;
  @post create(...Pet): Pet | Error;
  @patch update(...Pet): Pet | Error;
  @delete delete(@path id: int32): void | Error;


  // Custom operations 

  @doc("Donate given ammount of money to the specific pet. For food purposes only!")
  @route("{id}/donate/{ammount}")
  @post
  donate(@path id: int32, @path ammount: int32): boolean | Error;
}
