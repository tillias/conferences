import "@typespec/compiler";
import "@typespec/http";

using TypeSpec.Http;

namespace CloudApiLib;

// Common operatios for department, org unit, company ... (choose your best fit)


model List<T> {
    @doc("list of elements")
    value: T[];

    @doc("link to the next page of results if present")
    nextLink?: url;
}

@get op list<T, P = {}>(...P): List<T> | Error;

@get op read<T, P = {}>(...P, @path id: string): T | Error;

@post op create<T, P = {}>(...P, @body body: T): T | Error;

@patch op update<T, P = {}>(...P, @path id: string, @body body: MergePatch<T>): T | Error;

@delete op delete<T, P = {}>(...P, @path id: string): void | Error;

@post op postAction<T, P = {}>(...P): T | Error;

model MergePatch<T> {
    @header contentType: "application/merge-patch+json";
    ...T;
}

@error
model Error {
  code: int32;
  message: string;
}
