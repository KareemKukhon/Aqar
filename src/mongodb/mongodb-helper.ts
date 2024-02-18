import { Injectable } from '@tsed/di';
import { MongoClient } from 'mongodb';

@Injectable()
export class MongoDBService {
  private client: MongoClient;

  constructor() {
    this.client = new MongoClient('mongodb://localhost:27017/Aqar');
  }

  async connect() {
    await this.client.connect();
  }

  async disconnect() {
    await this.client.close();
  }

  async getCollection(name: string) {
    return this.client.db('qar').collection("Users");
  }
}
