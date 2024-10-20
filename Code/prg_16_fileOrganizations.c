#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 100
#define HASH_SIZE 10

// Structure for a record in a file
struct Record
{
  int id;
  char name[20];
};

// Hashing function for Direct File Organization
int hashFunction(int id)
{
  return id % HASH_SIZE;
}

// Sequential File Organization: Insert record
void sequentialInsert(FILE *file, struct Record rec)
{
  fwrite(&rec, sizeof(struct Record), 1, file);
}

// Sequential File Organization: Display records
void sequentialDisplay(FILE *file)
{
  struct Record rec;
  rewind(file); // Move pointer to the beginning of the file
  while (fread(&rec, sizeof(struct Record), 1, file))
  {
    printf("ID: %d, Name: %s\n", rec.id, rec.name);
  }
}

// Direct File Organization: Insert record (using hashing)
void directInsert(struct Record hashTable[], struct Record rec)
{
  int index = hashFunction(rec.id);
  while (hashTable[index].id != -1)
  {
    index = (index + 1) % HASH_SIZE;
  }
  hashTable[index] = rec;
}

// Direct File Organization: Display records
void directDisplay(struct Record hashTable[])
{
  for (int i = 0; i < HASH_SIZE; i++)
  {
    if (hashTable[i].id != -1)
    {
      printf("ID: %d, Name: %s (Index: %d)\n", hashTable[i].id, hashTable[i].name, i);
    }
  }
}

// Indexed File Organization: Insert record
void indexedInsert(FILE *dataFile, FILE *indexFile, struct Record rec)
{
  fseek(dataFile, 0, SEEK_END);    // Move to end of data file
  long position = ftell(dataFile); // Get current position in file
  fwrite(&rec, sizeof(struct Record), 1, dataFile);

  // Write index entry
  fwrite(&rec.id, sizeof(int), 1, indexFile);
  fwrite(&position, sizeof(long), 1, indexFile);
}

// Indexed File Organization: Display records
void indexedDisplay(FILE *dataFile, FILE *indexFile)
{
  int id;
  long position;
  struct Record rec;

  rewind(indexFile); // Move to the beginning of the index file
  while (fread(&id, sizeof(int), 1, indexFile) && fread(&position, sizeof(long), 1, indexFile))
  {
    fseek(dataFile, position, SEEK_SET); // Move to the position in data file
    fread(&rec, sizeof(struct Record), 1, dataFile);
    printf("ID: %d, Name: %s\n", rec.id, rec.name);
  }
}

int main()
{
  printf("\n5C6 - Amit Singhal (11614802722)\n");
  
  FILE *seqFile, *dataFile, *indexFile;
  struct Record hashTable[HASH_SIZE];
  struct Record rec;
  int choice, id, index;
  char name[20];

  // Initialize hash table for direct file organization
  for (int i = 0; i < HASH_SIZE; i++)
  {
    hashTable[i].id = -1; // Empty slot
  }

  // Open files for sequential and indexed file organization
  seqFile = fopen("sequential.dat", "wb+");
  dataFile = fopen("data.dat", "wb+");
  indexFile = fopen("index.dat", "wb+");

  if (!seqFile || !dataFile || !indexFile)
  {
    printf("Error opening file!\n");
    return 1;
  }

  do
  {
    printf("\nFile Organization Menu:\n");
    printf("1. Sequential Insert\n");
    printf("2. Sequential Display\n");
    printf("3. Direct Insert (Hashing)\n");
    printf("4. Direct Display (Hashing)\n");
    printf("5. Indexed Insert\n");
    printf("6. Indexed Display\n");
    printf("7. Exit\n");
    printf("Enter your choice: ");
    scanf("%d", &choice);

    switch (choice)
    {
    case 1:
      printf("Enter ID: ");
      scanf("%d", &rec.id);
      printf("Enter Name: ");
      scanf("%s", rec.name);
      sequentialInsert(seqFile, rec);
      break;

    case 2:
      sequentialDisplay(seqFile);
      break;

    case 3:
      printf("Enter ID: ");
      scanf("%d", &rec.id);
      printf("Enter Name: ");
      scanf("%s", rec.name);
      directInsert(hashTable, rec);
      break;

    case 4:
      directDisplay(hashTable);
      break;

    case 5:
      printf("Enter ID: ");
      scanf("%d", &rec.id);
      printf("Enter Name: ");
      scanf("%s", rec.name);
      indexedInsert(dataFile, indexFile, rec);
      break;

    case 6:
      indexedDisplay(dataFile, indexFile);
      break;

    case 7:
      printf("Exiting...\n");
      break;

    default:
      printf("Invalid choice!\n");
      break;
    }
  } while (choice != 7);

  fclose(seqFile);
  fclose(dataFile);
  fclose(indexFile);

  return 0;
}

