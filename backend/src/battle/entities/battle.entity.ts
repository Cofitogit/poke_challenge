import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  CreateDateColumn,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { Pokemon } from '../../pokemon/entities/pokemon.entity';

@Entity()
export class Battle {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  playerPokemonId: string;

  @Column()
  computerPokemonId: string;

  @Column()
  winnerId: string;

  @Column()
  turns: number;

  @Column('simple-json')
  battleLog: { turn: number; action: string; result: string }[];

  @CreateDateColumn()
  createdAt: Date;

  @ManyToOne(() => Pokemon)
  @JoinColumn({ name: 'playerPokemonId' })
  playerPokemon: Pokemon;

  @ManyToOne(() => Pokemon)
  @JoinColumn({ name: 'computerPokemonId' })
  computerPokemon: Pokemon;

  @ManyToOne(() => Pokemon)
  @JoinColumn({ name: 'winnerId' })
  winner: Pokemon;
}
