import "@typespec/http";
import "./model.tsp";
import "./library.tsp";

using TypeSpec.Http;
using CloudApiLib;

@service({
  title: "Pet Store Service",
  version: "2021-03-25",
})
@server("https://example.com", "Single server endpoint")
namespace Pets;

@route("/pets")
@tag("pet")
interface PetStore {
  getPets is list<Pet>;
  getPetById is read<Pet>;
  createPet is create<Pet>;
  updatePet is update<Pet>;
  deletePet is delete<Pet>;

  @route(":search")
  search is postAction<List<Pet>, {@body searchString: string}>;
}

@route("/insurance")
@tag("insurance")
interface PetInsurance {
  insurePet is create<InsurancePolicy>;
  updateInsurance is update<InsurancePolicy>;
  deleteInsurance is delete<InsurancePolicy>;
  findInsuranceById is read<InsurancePolicy>;
}

@route("/claims")
@tag("claim")
interface PetInsuranceClaims {
  fileClaim is create<InsuranceClaim>;
  updateClaim is update<InsuranceClaim>;
  deleteClaim is delete<InsuranceClaim>;

  @route(":search")
  searchAllClaims is postAction<List<InsuranceClaim>, {@body petId: string}>;
}
