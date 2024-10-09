import { AppDataSource } from "./src/data-source";
import { TaskTypes } from "./src/entity/TaskTypes.entity"; // Adjust the import based on your entity location
import { AddPriceDetails } from "./src/entity/AddPriceDetails.entity"; // Import AddPriceDetails

async function seed() {
  // Initialize the data source
  await AppDataSource.initialize();

  // Define task types
  const taskTypes = [
    { name: "Cleaning", originalPrice: 100000 },
    { name: "Cooking", originalPrice: 100000 },
    { name: "Laundry", originalPrice: 100000 },
    { name: "Grocery Shopping", originalPrice: 100000 },
    { name: "Gardening", originalPrice: 100000 },
  ];
  const addPriceDetails = [
    {
      taskTypeId: 1,
      name: "Dien tich",
      stepPrice: 10000,
      beginPrice: 10000,
      stepValue: 20,
      unit: "m2",
      beginValue: 20,
    },
    {
      taskTypeId: 1,
      name: "So phong",
      stepPrice: 10000,
      beginPrice: 10000,
      stepValue: 1,
      unit: "phong",
      beginValue: 1,
    },

    {
      taskTypeId: 2,
      name: "Dien tich",
      stepPrice: 10000,
      beginPrice: 10000,
      stepValue: 20,
      unit: "m2",
      beginValue: 20,
    },
  ];

  // Create and save task types
  for (const taskTypeData of taskTypes) {
    const taskType = new TaskTypes();
    taskType.name = taskTypeData.name;
    taskType.originalPrice = taskTypeData.originalPrice;
    await AppDataSource.manager.save(taskType);
  }
  for (const addPriceDetailsData of addPriceDetails) {
    const addPriceDetail = new AddPriceDetails();
    addPriceDetail.taskTypeId = addPriceDetailsData.taskTypeId;
    addPriceDetail.name = addPriceDetailsData.name;
    addPriceDetail.stepPrice = addPriceDetailsData.stepPrice;
    addPriceDetail.beginPrice = addPriceDetailsData.beginPrice;
    addPriceDetail.stepValue = addPriceDetailsData.stepValue;
    addPriceDetail.unit = addPriceDetailsData.unit;
    addPriceDetail.beginValue = addPriceDetailsData.beginValue;

    await AppDataSource.manager.save(addPriceDetail); // Save individual instance
  }

  // Close the data source
  await AppDataSource.destroy();
}

// Run the seed function
seed().catch((error) => console.log(error));
